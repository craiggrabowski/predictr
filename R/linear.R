#' @include predictr.R
NULL

Vector <-
setClass("Vector",
  slots = list(
    name = "character",
    data = "numeric"
  ),
  validity = function(object) {
    if (length(object@name) != 1L)
      return("Name must be a scalar")

    if (any(is.na(object@data)))
      return("Data can't have missing values")

    TRUE
  },
  contains = "Action"
)

Linear <-
setClass("Linear", contains = "Vector")


#' Returns a linear object
#'
#' \code{linear} returns an linear object.
#'
#' A linear object corresponds with the most common type of
#' summand in a linear-based model,
#' namely one equal to a parameter \eqn{a} times the value of a
#' covariate \eqn{x}.
#' The summand has the following form:
#'
#' \eqn{a * x}
#'
#' In the case of a univariate model,
#' \eqn{a} is a scalar.
#' For multivariate models,
#' \eqn{a} is a vector.
#'
#' Specifying the linear object requires two data elements.
#' The first element, \code{x},
#' is the name of the field associated with the covariate.
#' This name indicates how to identify the covariate in a table
#' of data.
#' The second element,
#' \code{data},
#' is the parameter,
#' which can be a scalar or a vector.
#'
#' @param x Name of object
#'
#' @param data vector (defaults to 0)
#'
#' @export
linear <- function(x, data = 0) {
  Linear(name = x, data = as.numeric(data))
}

originate.Linear <- function(x, ...) {
  name <- x@name
  v <- x@data

  function(df) {
    .subset2(df, name) %*% t(v)
  }
}

accumulate.Linear <- function(x, ...) {
  p <- x@data
  s <- x@name
  function(m, df) accumulate_linear_cpp(m, p, .subset2(df, s))
}

#' A method to generate linear objects
#'
#' \code{as.linear_list} returns a list of linear objects.
#'
#' This method converts objects into a list of the linear terms
#' within the (model) object,
#' or an empty list if the supplied object has no corresponding
#' linear terms.
#'
#' @param x Object to be converted
#'
#' @param ... Additional options
#'
#' @export
as.linear_list <- function(x, ...)
  UseMethod("as.linear_list")

