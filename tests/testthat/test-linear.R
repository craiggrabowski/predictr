library(predictr)
context("linear")

test_that("Name must be a scalar", {
  expect_error(linear(c("a", "b")), "Name must be a scalar")
})

test_that("Can't have missing values", {
  f <- function(x) expect_error(
    linear("x", data = x),
    "Linear can't have missing values"
  )

  xx <- list(
    NA,
    c(NA, 2),
    c(3, NA)
  )

  lapply(xx, f)
})

test_that("Can create basic object", {
  expect_true({ linear("x"); TRUE })
})
