library(predictr)

context("intercept")

test_that("Missing data produces an error", {
  expect_error(intercept(NA), "intercept can't have missing values")
})

test_that("Converts to function", {
  x <- intercept(seq(2))
  f <- as.function(x)
  df <- data.frame(x = seq(12L))

  expect_equal(
    f(df),
    cbind(rep(1, 12L), rep(2, 12L))
  )
})
