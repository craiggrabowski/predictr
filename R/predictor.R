#' @include intercept.R
#' @include linear.R
NULL

#' Returns a predictor object
#'
#' \code{predictor} returns a predictor object
#'
#' @param x (Model) object
#'
#' @param ... Additional options
#'
#' @return A predictor object corresponding with \code{x}
#'
#' @export
predictor <- function(x, ...)
  UseMethod("predictor")


Predictor <-
setClass("Predictor",
  slots = list(
    data = "list"
  )
)

as.function.Predictor <- function(x, ...) {
  o <- originate(x@data[[1L]])
  ff <- lapply(x@data[-1L], function(y) as.function(y, ...))

  compiler::cmpfun(function(df) {
    m <- o(df)
    for (f in ff) m <- m + f(df)
    m
  })
}

predict.Predictor <- function(object, ...) {
  as.function.Predictor(object, ...)(...)
}

predictor.default <- function(x, ...) Predictor(data = c(
  as.intercept_list(x, ...),
  as.linear_list(x, ...),
  as.lookup_list(x, ...),
  as.boolean_list(x, ...)
))

predictor.Predictor <- function(x, ...) x
