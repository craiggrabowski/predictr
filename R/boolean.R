#' @include predictr.R
#' @include linear.R
NULL

Boolean <-
setClass("Boolean", contains = "Vector")

#' Returns a boolean object
#'
#' \code{linear} returns an boolean object.
#'
#'
#' @param x Name of object
#'
#' @param data vector (defaults to 0)
#'
#' @export
boolean <- function(x, data = 0) {
  Boolean(name = x, data = as.numeric(data))
}
