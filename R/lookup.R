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
