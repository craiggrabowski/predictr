library(predictr)
context("lookup")

test_that("Non-scalar name produces an error", {
  expect_error(
    lookup(
      x = rep("x", 2L),
      data = matrix(0, nrow = 2L, ncol = 2L),
      levels = c(TRUE, FALSE)
    ),
    "Name must be a scalar"
  )
})

test_that("Missing name produces an error", {
  expect_error(
    lookup(
      x = NA,
      data = matrix(0, nrow = 2L, ncol = 2L),
      levels = c(TRUE, FALSE)
    ),
    "Name can't be missing"
  )
})

test_that("Missing data produces an error", {
  expect_error(
    lookup(
      x = "x",
      data = matrix(c(0,1,NA,2), nrow = 2L, ncol = 2L),
      levels = c(TRUE, FALSE)
    ),
    "Data can't have missing elements"
  )
})

test_that("Dimension mismatch produces an error", {
  expect_error(
    lookup(
      x = "x",
      data = matrix(0, nrow = 1L, ncol = 2L),
      levels = c(TRUE, FALSE)
    ),
    "Dimension mismatch between data and levels"
  )
})
