
<!-- README.md is generated from README.Rmd. Please edit that file -->
    ## Loading predictr

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
#>               expr       min        lq      mean   median       uq
#>  predict(model, a) 19.506860 23.717283 30.997413 26.32266 28.97714
#>      predict(x, a)  2.454093  2.841267  6.167095  3.29282  5.51482
#>       max neval
#>  85.31133   100
#>  49.27016   100
```

Third, the new object converts to a predict function which is even faster:

``` r
f <- as.function(x)
microbenchmark::microbenchmark(predict(x, a), f(a))
#> Unit: microseconds
#>           expr      min        lq      mean   median       uq       max
#>  predict(x, a) 2426.930 2525.1380 3520.1553 2627.052 3180.952 46215.425
#>           f(a)  519.401  527.9195  799.4557  555.207 1190.919  2034.474
#>  neval
#>    100
#>    100
```
