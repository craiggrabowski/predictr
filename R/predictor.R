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
  ff <- lapply(x@data, function(y) as.function(y, ...))

  compiler::cmpfun(function(df) {
    m <- ff[[1]](df)
    for (f in ff[-1L]) m <- m + f(df)
    m
  })
}

predict.Predictor <- function(object, ...) {
  as.function.Predictor(object, ...)(...)
}

predictor.default <- function(x, ...) Predictor(data = c(
  as.intercept_list(x, ...),
  as.linear_list(x, ...)
))

predictor.Predictor <- function(x, ...) x
