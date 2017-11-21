
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
#>  predict(model, a) 19.921669 24.164629 33.914053 26.495027 29.274725
#>      predict(x, a)  2.579478  3.006354  5.845861  3.518158  5.264399
#>        max neval
#>  103.05793   100
#>   63.20291   100
```

Third, the new object supports a conversion to a function using `as.function()`. This return value of this converion is a function which implements `predict()` as well, only now the compute time is much smaller:

``` r
f <- as.function(x)
microbenchmark::microbenchmark(predict(x, a), f(a))
#> Unit: microseconds
#>           expr      min        lq     mean    median       uq      max
#>  predict(x, a) 2532.859 2654.7950 3098.863 2906.9775 3456.623  4614.86
#>           f(a)  505.241  512.2505 1211.987  546.8825  780.943 49529.01
#>  neval
#>    100
#>    100
```
