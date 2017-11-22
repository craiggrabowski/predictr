#' @include predictr.R
#' @include lookup.R
NULL

#' Returns a boolean object
#'
#' \code{boolean} returns an boolean object.
#'
#'
#' @param x Name of object
#'
#' @param data matrix
#'
#' @export
boolean <- function(x, data = matrix()) {
  Lookup(name = x, data = data, levels = c(FALSE, TRUE))
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

