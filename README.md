
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

This is a basic example which illustrates the main method:

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

In this example, we call predictor on a model object produced using linear regression. This new object implements the predict method, except now the output is expressed as a matrix. There are a few reasons for performing this extra step. First, the new object is significantly smaller than the existing model object:

``` r
pryr::object_size(model)
#> 134 kB
pryr::object_size(x)
#> 1.61 kB
```

Second, the predict method is now faster for large data:

``` r
a <- data.frame(x = seq(100000))
microbenchmark::microbenchmark(predict(model, a), predict(x, a))
#> Unit: milliseconds
#>               expr       min        lq      mean    median        uq
#>  predict(model, a) 22.310242 24.611107 34.950690 27.360280 30.834233
#>      predict(x, a)  2.442478  2.836013  4.596194  3.171206  4.811193
#>       max neval
#>  80.56022   100
#>  48.63521   100
```

Third, the new object converts to a predict function which is even faster:

``` r
f <- as.function(x)
microbenchmark::microbenchmark(predict(x, a), f(a))
#> Unit: microseconds
#>           expr      min        lq     mean    median       uq       max
#>  predict(x, a) 2421.916 2535.7430 3611.650 2712.5435 3255.985 45110.072
#>           f(a)  520.497  541.2795  829.199  567.9105 1192.124  4044.157
#>  neval
#>    100
#>    100
```
