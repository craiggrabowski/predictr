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

test_that("predictor produces same predictions", {
  df <- data.frame(x = seq(12L), y = seq(12L) + 1L)
  f <- function(x) {
      expect_equal(
        as.numeric(predict(predictor(x), df)),
        { z <- predict(x, df); names(z) <- NULL; z }
      )
  }

  xx <- list(
    lm(y ~ 1, df),
    lm(y ~ x, df),
    lm(y ~ x + 0, df)
  )

  lapply(xx, f)
})

test_that("predictor works on categorical models", {
  df <- data.frame(
    x = rep(c("a", "b"), 6L),
    a = seq(12L),
    y = rep(seq(2L), 6L)
  )
  f <- function(x) {
    expect_equal(
      as.numeric(predict(predictor(x), df)),
      { z <- predict(x, df); names(z) <- NULL; z }
    )
  }

  xx <- list(
    lm(y ~ x, df),
    lm(y ~ x + 0, df),
    lm(y ~ x + a, df),
    lm(y ~ x + a + 0, df)
  )

  lapply(xx, f)
})

test_that("predictor works on models with booleans", {
  df <- data.frame(
    x = rep(c(FALSE, TRUE), 6L),
    y = rep(seq(2), 6L)
  )

  f <- function(x) expect_equal(
    as.numeric(predict(predictor(x), df)),
    { x <- predict(x, df); names(x) <- NULL; x}
  )
  xx <- list(
    lm(y ~ x, df)
    # lm(y ~ x + 0, df)
  )

  lapply(xx, f)
})
