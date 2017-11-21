#' @include predictr.R
NULL

Lookup <-
setClass("Lookup",
  slots = list(
    name = "character",
    data = "matrix",
    levels = "ANY"
  ),
  validity = function(object) {
    if (length(object@name) != 1L)
      return("Name must be a scalar")

    if (is.na(object@name))
      return("Name can't be missing")

    if (any(is.na(object@data)))
      return("Data can't have missing elements")

    if (nrow(object@data) != length(object@levels))
      return("Dimension mismatch between data and levels")
    TRUE
  }
)

as.function.Lookup <- function(x, ...) {

  n <- x@name
  m <- x@data
  levels <- x@levels

  function(df) {
    v <- .subset2(df, n)
    I <- match(v, levels)
    m[I,]
  }
}


#' Returns a lookup object
#'
#' \code{lookup} returns a lookup object.
#'
#' @param x Name of input variable
#'
#' @param data Lookup table values
#'
#' @param levels Levels in lookup table
#'
#' @export
lookup <- function(x, data, levels) {
  Lookup(name = as.character(x), data = data, levels = levels)
}

#' A method to generate lookup objects
#'
#' \code{as.lookup_list} returns a list of lookup objects.
#'
#' This method converts objects into a list of the lookup terms
#' within the (model) object,
#' or an empty list if the supplied object has no corresponding
#' lookup terms.
#'
#' @param x Object to be converted
#'
#' @param ... Additional options
#'
#' @export
as.lookup_list <- function(x, ...)
  UseMethod("as.lookup_list")
