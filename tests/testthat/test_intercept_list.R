library(predictr)
context("as.intercept_list")

test_that("Default return value is empty list", {
  f <- function(x) expect_equal(as.intercept_list(x), list())

  xx <- list(
    TRUE,
    character(0),
    rep(98.6, 12L),
    seq(4L),
    function(x) x
  )

  lapply(xx, f)
})
