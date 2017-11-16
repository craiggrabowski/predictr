library(predictr)
context("predictor")

test_that("predictor is idempotent", {
  f <- function(x) expect_equal(
    predictor(predictor(x)),
    predictor(x)
  )

  df <- data.frame(x = seq(12L), y = seq(12L) + 1L)

  xx <- list(
    lm(y ~ 1, df),
    lm(y ~ x, df),
    lm(y ~ x + 0, df)
  )

  lapply(xx, f)
})
