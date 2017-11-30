
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
#>               expr       min        lq      mean    median        uq
#>  predict(model, a) 18.875002 22.784032 33.809279 24.919282 27.280293
#>      predict(x, a)  1.639926  1.915395  3.067028  2.165641  2.440346
#>       max neval
#>  90.07108   100
#>  50.03843   100
```

Third, the new object supports a conversion to a function using `as.function()`. This return value of this converion is a function which implements `predict()` as well, only now the compute time is much smaller:

``` r
f <- as.function(x)
microbenchmark::microbenchmark(predict(x, a), f(a))
#> Unit: microseconds
#>           expr      min       lq      mean   median       uq      max
#>  predict(x, a) 1631.693 1664.351 1924.7329 1724.274 2135.965 3426.342
#>           f(a)  185.949  208.481  390.2227  216.476  311.847 2296.787
#>  neval
#>    100
#>    100
```
