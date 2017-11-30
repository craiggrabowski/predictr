#' @include predictr.R
#' @include action.R
NULL


Intercept <-
setClass("Intercept",
  slots = list(
    data = "numeric"
  ),
  validity = function(object) {
    if (any(is.na(object@data)))
      return("intercept can't have missing values")

    TRUE
  },
  contains = "Action"
)

#' Returns an intercept object
#'
#' \code{intercept} returns an intercept object.
#'
#'
#' @param x Intercept vector (default to 0)
#'
#' @export
intercept <- function(x = 0) {
  Intercept(data = as.numeric(x))
}

#' @export
originate.Intercept <- function(x, ...) {
  data <- x@data
  function(df) {
    originate_intercept_cpp(nrow(df), data)
  }
}

#' Return a list of intercept objects
#'
#' \code{as.intercept_list} returns a list of intercept objects.
#'
#' This method extracts the intercept information from a model
#' object.
#' If the object has an intercept,
#' the return value is a list of length one
#' whose inner object is an intercept object.
#' If the object does not have an intercept,
#' the return value is an empty list.
#'
#' @param x Object to convert to intercepts
#'
#' @param ... Other options
#'
#' @return A list of intercept objects of length 0 or 1
#'
#' @export
as.intercept_list <- function(x, ...)
  UseMethod("as.intercept_list")

#' @export
as.intercept_list.default <- function(x, ...) list()
