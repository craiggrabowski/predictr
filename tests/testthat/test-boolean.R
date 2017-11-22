library(predictr)
context("boolean")

test_that("Name must be a scalar", {
  expect_error(boolean(c("a", "b")), "Name must be a scalar")
})


