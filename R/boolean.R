#' @include predictr.R
#' @include lookup.R
NULL

#' Returns a boolean object
#'
#' \code{boolean} returns an boolean object.
#'
#' This function returns an object associated with logical or
#' boolean terms in a linear model.
#' The object stores the parameters as a matrix,
#' which the user supplies as the \code{data} parameter.
#' The first row contains the parameters associated with
#' a value of \code{FALSE},
#' and the second row contains the parameters associated
#' with a value of \code{TRUE}.
#' In many models,
#' there are no parameters for \code{FALSE},
#' in which case all of the values in the row are zero.
#'
#' @param x Name of object
#'
#' @param data Matrix of parameters
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

