
<!-- README.md is generated from README.Rmd. Please edit that file -->
predictr
========

[![Travis-CI Build Status](https://travis-ci.org/craiggrabowski/predictr.svg?branch=master)](https://travis-ci.org/craiggrabowski/predictr) [![codecov](https://codecov.io/gh/craiggrabowski/predictr/branch/master/graph/badge.svg)](https://codecov.io/gh/craiggrabowski/predictr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/craiggrabowski/predictr?branch=master&svg=true)](https://ci.appveyor.com/project/craiggrabowski/predictr)

The goal of predictr is to allow for model predictions which minimize memory usage and computing time. This package provides a new type of object and adaptors for various common model types.

Installation
------------

You can install predictr from github with:

``` r
# install.packages("devtools")
devtools::install_github("craiggrabowski/predictr")
```

Example
-------

This is a basic example which illustrates `predictor()`, the main method defined in this package:

``` r
## basic example code
v <- seq(1024)
df <- data.frame(x = v, y = v + 1)
model <- lm(y ~ x, df)
x <- predictor(model)
predict(x, data.frame(x = c(2, 3)))
#>      [,1]
#> [1,]    3
#> [2,]    4
```

We create a model object using linear regression and then convert to a new object using `predictor()`. This new object implements the `predict()` method, but its implementation does not produce the same results as the original regression object. In particular, the output is now expressed as a matrix instead of a numeric vector.

The new object created by `predictor()` has a few advantages over the object produced using a call to `lm()`. First, the new object is significantly smaller than the existing model object:

``` r
pryr::object_size(model)
#> 134 kB
pryr::object_size(x)
#> 1.61 kB
```

Second, the `predict()` method is now faster for large data:

``` r
a <- data.frame(x = seq(100000))
microbenchmark::microbenchmark(predict(model, a), predict(x, a))
#> Unit: milliseconds
#>               expr       min        lq     mean    median        uq
#>  predict(model, a) 18.770114 21.573490 35.38808 24.744998 30.277616
#>      predict(x, a)  1.821072  2.127459  2.79398  2.384389  2.605109
#>        max neval
#>  94.634500   100
#>   9.786381   100
```

Third, the new object supports a conversion to a function using `as.function()`. This return value of this converion is a function which implements `predict()` as well, only now the compute time is much smaller:

``` r
f <- as.function(x)
microbenchmark::microbenchmark(predict(x, a), f(a))
#> Unit: microseconds
#>           expr      min       lq      mean   median       uq      max
#>  predict(x, a) 1793.679 2000.526 2432.2403 2190.113 2657.898 5245.185
#>           f(a)  341.660  370.430  549.6333  397.025  468.387 2301.677
#>  neval
#>    100
#>    100
```
