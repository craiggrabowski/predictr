library(predictr)
context("boolean")

test_that("Name must be a scalar", {
  expect_error(boolean(c("a", "b")), "Name must be a scalar")
})

test_that("Can't have missing values", {
  f <- function(x) expect_error(
    boolean("x", data = x),
    "Data can't have missing values"
  )

  xx <- list(
    NA,
    c(NA, 2),
    c(3, NA)
  )

  lapply(xx, f)
})
