#' @include intercept.R
NULL

as.intercept_list.lm <- function(x, ...) {
  y <- coef(x)
  if (!("(Intercept)" %in% names(y)))
    return(list())

  n <- which(names(y) == "(Intercept)")
  n <- y[n]
  names(n) <- NULL
  list(intercept(n))
}
