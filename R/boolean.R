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


as.function.Boolean <- function(x, ...) {
  name <- x@name
  v <- x@data

  function(df) {
    .subset2(df, name) %*% t(v)
  }
}

#' A method to generate boolean objects
#'
#' \code{as.boolean_list} returns a list of boolean objects.
#'
#' This method converts objects into a list of the boolean terms
#' within the (model) object,
#' or an empty list if the supplied object has no corresponding
#' boolean terms.
#'
#' @param x Object to be converted
#'
#' @param ... Additional options
#'
#' @export
as.boolean_list <- function(x, ...)
  UseMethod("as.boolean_list")

