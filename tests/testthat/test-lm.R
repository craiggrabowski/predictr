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
