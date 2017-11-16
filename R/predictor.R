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
