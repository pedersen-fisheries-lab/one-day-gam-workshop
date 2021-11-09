# One-day Introduction to GAMs workshop

A short course on how to fit, plot, and evaluate GAMs

## Setup

  - You will need to install **R** and I recommend using **RStudio**. The
    latest version of R can be downloaded
    [here](https://cran.r-project.org/mirrors.html). RStudio is an application
    (an integrated development environment or IDE) that facilitates the use of R
    and offers a number of nice additional features. It can be downloaded
    [here](https://www.rstudio.com/products/rstudio/download/). You will need
    the free Desktop version for your computer.

  - Download the course materials as a ZIP file
    [here](https://github.com/pedersen-fisheries-lab/one-day-gam-workshop/archive/main.zip).
    Alternatively, if you have the [**usethis**](), R package, running the
    following command will download the course materials and open them:

    ``` {.r}
    usethis::use_course('pedersen-fisheries-lab/one-day-gam-workshop')
    ```

  - Install the R packages required for this course by running the following
    line of code your R console:

    ``` {.r}
    install.packages(c("dplyr", "ggplot2", "remotes", "mgcv", "tidyr"))
    remotes::install_github("gavinsimpson/gratia")
    ```
    
## Day 1 info


[Introduction slides](slides/00-Course-intro.html)

[Day 1 slides](slides/slides/01-1D-smoothing.html)

[Day 1 script](scripts/01-intro-to-gams.R)

[Day 1 solutions](scripts/01-intro-to-gams - solutions.R)



## Day 2 info

[Day 1 slides](slides/slides/slides/02-extending-gams.html)



