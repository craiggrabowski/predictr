library(predictr)
context("lm")

test_that("intercept_list for no intercept is empty", {
  df <- data.frame(x = seq(12L), y = seq(12L) + 1L)
  x <- lm(y ~ x + 0, data = df)
  expect_equal(
    as.intercept_list(x),
    list()
  )
})

test_that("intercept_list returns intercept", {
  df <- data.frame(x = seq(12L), y = seq(12L) + 1L)
  x <- lm(y ~ x, data = df)
  expect_equal(
    as.intercept_list(x),
    list(intercept(1))
  )
})

test_that("as.linear_list returns list() when no linear terms", {
  f <- function(x) expect_equal(as.linear_list(x), list())

  df <- data.frame(x = seq(12L), y = seq(12L) + 1L)
  xx <- list(
    lm(y ~ 1, data = df)
  )

  lapply(xx, f)
})
