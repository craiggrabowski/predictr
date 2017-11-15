#' @include predictr.R
NULL

Linear <-
setClass("Linear",
  slots = list(
    name = "character",
    data = "numeric"
  ),
  validity = function(object) {
    if (length(object@name) != 1L)
      return("Name must be a scalar")

    if (any(is.na(object@data)))
      return("Linear can't have missing values")

    TRUE
  }
)

#' Returns a linear object
#'
#' \code{linear} returns an linear object.
#'
#'
#' @param x Name of object
#'
#' @param data vector (defaults to 0)
#'
#' @export
linear <- function(x, data = 0) {
  Linear(name = x, data = as.numeric(data))
}

