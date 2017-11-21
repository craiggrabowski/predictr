library(predictr)
context("linear")

test_that("Name must be a scalar", {
  expect_error(linear(c("a", "b")), "Name must be a scalar")
})

test_that("Can't have missing values", {
  f <- function(x) expect_error(
    linear("x", data = x),
    "Data can't have missing values"
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

test_that("Converts to function as expected", {
  df <- data.frame(x = seq(12L))
  x <- linear("x", data = seq(2))
  f <- as.function(x)

  expect_equal(
    f(df),
    cbind(df$x, 2 * df$x)
  )
})
