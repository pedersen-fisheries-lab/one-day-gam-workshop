# example and practical scripts for part 04!

# load requisite packages
library('mgcv')
library('gratia')
library('ggplot2')
library('dplyr')

# load the data
trawls <- read.csv("data/trawl_nl.csv")

flu_data <- read.csv("data/california-flu-data.csv") %>%
  mutate(season = factor(season))

#filter to just one year for now
flu2010_data <- flu_data %>%
  filter(season=="2010-2011")


# Following along with the slides #### 

flu2010_posmod <- gam(tests_pos ~ s(week_centered, k = 15) + offset(log(tests_total)),
                      data= flu2010, 
                      family = poisson,
                      method = "REML")

ggplot(flu2010, aes(x =week_centered, y=tests_pos/tests_total)) +
  geom_point()+
  labs(x="Week (centered)", y="Fraction of positive tests")

plot(flu2010_posmod)
draw(flu2010_posmod)


sm_fit <- evaluate_smooth(flu2010_posmod, 's(week_centered)') # tidy data on smooth
sm_post <- smooth_samples(flu2010_posmod, 's(week_centered)', n = 20, seed = 42) # more on this later
draw(sm_fit) + geom_line(data = sm_post, aes(x = .x1, y = value, group = draw),
                         alpha = 0.3, colour = 'red')



## Exercise 1

# Let's explore some of the plotting options for GAMs and how we can control what kinds of intervals are drawn

# First we'll re-fit a model of species richness in the trawl data from the last session



rich_depthyear <- gam(richness~s(log10(depth), k=30) +s(year, k=10), 
                     family=poisson,
                     method="REML", 
                     data=trawls)

# Here's how to plot this model on a single page using the `plot` function:

plot(rich_depthyear, pages=1)

# 1. Draw the estimated smooth again, this time using `seWithMean = TRUE`. Does it change the plot much? Think why this is the case.
# 2. Using `draw()`, draw the estimated smooth
# 3. Repeat 2 but this time account for the additional uncertainty due to estimating the smoothness parameters using `unconditional = TRUE`

# Now let's explore working with smooths in a little more detail. First evaluate the smooth over a range of values for `year`
depth_sm <- evaluate_smooth(rich_depthyear, "s(log10(depth))")
depth_sm

# We can add a confidence interval to `year_sm` by hand or use the `confint()` methof
depth_sm <- confint(rich_depthyear, "s(log10(depth))")
depth_sm


# Posterior simulation code ####

sm_week <- get_smooth(flu2010_posmod, "s(week_centered)") # extract the smooth object from model
idx <- gratia:::smooth_coefs(sm_week)    # indices of the coefs for this smooth
idx

beta <- coef(flu2010_posmod)                     # vector of model parameters


#Extracting the variance-covariance matrix

Vb <- vcov(flu2010_posmod) # default is the bayesian covariance matrix

new_weeks <- with(flu2010, tibble(week_centered = seq_min_max(week_centered, n = 100),
                                  tests_total = 1))
Xp <- predict(flu2010_posmod, newdata = new_weeks, type = 'lpmatrix')
dim(Xp)

#Take only the columns of Xp that are involved in the smooth of `year`

Xp <- Xp[, idx, drop = FALSE]
dim(Xp)

# Simulate from the posterior: 

set.seed(42)
beta_sim <- rmvn(n = 20, beta[idx], Vb[idx, idx, drop = FALSE])
dim(beta_sim)

sm_draws <- Xp %*% t(beta_sim)
dim(sm_draws)
matplot(sm_draws, type = 'l')

# Using smooth_samples to draw from the posterior:

sm_post <- smooth_samples(flu2010_posmod, 's(week_centered)', n = 20, seed = 42)
draw(sm_post)


# Drawing posteriors for the predicted response values:

beta <- coef(flu2010_posmod)   # vector of model parameters
Vb <- vcov(flu2010_posmod)     # default is the bayesian covariance matrix
Xp <- predict(flu2010_posmod, type = 'lpmatrix')
set.seed(42)
beta_sim <- rmvn(n = 1000, beta, Vb) # simulate parameters
eta_p <- Xp %*% t(beta_sim)        # form linear predictor values
mu_p <- inv_link(flu2010_posmod)(eta_p)    # apply inverse link function

mean(mu_p[1, ]) # mean of posterior for the first observation in the data
quantile(mu_p[1, ], probs = c(0.025, 0.975))


# Exercise 2: 

# 1. Use the smooth_samples function to calculate 20 posterior draws from the 
# `rich_depthyear` model for the log10(depth) term and the year term
# 2. Plot those samples using the draw function.
# 3. Visually evaluate where the uncertainty is the greatest for each term


