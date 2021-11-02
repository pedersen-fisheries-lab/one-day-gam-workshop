---
title: Course syllabus
---

# Overview

This is a 3-session, one-day workshop. It was developed with the goal of giving you enough GAM knowledge to feel comfortable fitting and working with GAMs in your day-to-day modelling practice, with just enough of more advanced applications to give a flavour of what GAMs can do. I will be covering a basic intro to GAM theory, with the rest focused on practical applications and a few advanced topics that I think might be interesting.

# Learning Goals

-   Understand the basic GAM model, basis functions, and penalties
-   Fit 1D, 2D, and tensor-product GAMs to normal and non-normal data
-   Plot GAM fits, and understand how to explain GAM outputs
-   Diagnose common mispecification problems when fitting GAMs
-   Use GAMs to make predictions about new data, and assess model uncertainty
-   See how more complicated GAM models can be used as part of a modern workflow

# Syllabus

## 1. What is a GAM, and 1d smoothers


-   *Example data: temperature with depth*

-   refresher on GLMs (regression, parameters, link functions)

-   why smooth?

-   simple models with `s()`

-   introduction to the data

-   adding more than one smooth to your model

-   `summary` and `plot`

## 2. "twiddling knobs in `gam`"

-   moving beyond normal data (richness, shrimp biomass)

    -   exponential family and conditionally exp family (i.e., `family` + `tw` + `nb`)

-   more dimensions (Shrimp biomass)

    -   thin-plate 2d (Shrimp biomass with space)

    -   what are tensors? (Shrimp biomass as a function of depth and temperature)

        -   `ti` vs `te`

    -   spatio-temporal modelling

        -   `te(x,y,t)` constructions

-   centering constraints

    -   what does the intercept mean?

## 3. prediction, uncertainty, model checking, and selection 


-   using `predict` to calculate confidence intervals

-   posterior simulation

-   `gam.check` for model checking

-   quantile residuals

-   diagnostic: `DHARMa`

-   fitting to the residuals

-   `AIC` etc.

-   shrinkage and `select=TRUE`

# Other useful resources

  [3-day GAM workshop for DFO, a longer version of this workshop](https://github.com/pedersen-fisheries-lab/DFO-3day-gam-workshop/)
  
   [Our ESA GAM workshop](https://eric-pedersen.github.io/mgcv-esa-workshop/)
   
   [Our paper on Hierarchical Generalized Additive Models](https://peerj.com/articles/6876/)
   
 [Noam Ross's GAMs in R tutorial](https://noamross.github.io/gams-in-r-course/)
 
 [Noam Ross's Short talk on many types of models that can fit with mgcv](https://raw.githubusercontent.com/noamross/gam-resources/master/2017-11-14-noamross-gams-nyhackr.pdf)
 
 [Gavin Simpson's Blog: From the Bottom of the Heap](https://fromthebottomoftheheap.net/)
 
 [Gavin Simpson's Online GAM workshop](https://www.youtube.com/watch?v=sgw4cu8hrZM&feature=youtu.be)

[David Miller's NOAA workshop](https://converged.yt/mgcv-workshop/) based on the ESA workshop

[ David Miller's Distance DSM workshop](http://workshops.distancesampling.org/online-dsm-2020/)




# Other useful GAM resources:

 - Simon Wood's book "Generalized Additive Models: An Introduction with R, Second Edition", is an incredibly useful tool for learning about GAMs, and covers all of this material in depth.
 
- Hefley et al. (2017). "The basis function approach for modeling autocorrelation in ecological data". This is a great paper laying out how basis functions are used to model complex spatially structured systems. 


- The `mgcVis` package has more tools for plotting GAM model outputs. See Fasiolo et al.'s paper 2019 "Scalable visualization methods for modern generalized additive models". 
