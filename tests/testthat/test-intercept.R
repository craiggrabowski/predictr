library(predictr)

context("intercept")

test_that("Missing data produces an error", {
  expect_error(intercept(NA), "intercept can't have missing values")
})
