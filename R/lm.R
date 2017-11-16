#' @include intercept.R
#' @include linear.R
NULL

lm_intercept_string <- "(Intercept)"

as.intercept_list.lm <- function(x, ...) {
  y <- coef(x)
  if (!(lm_intercept_string %in% names(y)))
    return(list())

  n <- which(names(y) == lm_intercept_string)
  n <- y[n]
  names(n) <- NULL
  list(intercept(n))
}

as.linear_list.lm <- function(x, ...) {
  y <- coef(x)
  y <- y[names(y) != lm_intercept_string]

  lapply(seq_along(y), function(i)
    linear(names(y)[i], y[i])
  )
}
