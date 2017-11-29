#' @include predictr.R
NULL

setClass("Action")

#' @export
as.function.Action <- function(x, ...) {
  originate(x, ...)
}

originate <- function(x, ...)
  UseMethod("originate")

accumulate <- function(x, ...)
  UseMethod("accumulate")

accumulate.default <- function(x, ...) {
  f <- originate(x, ...)
  function(m, df) m + f(df)
}
