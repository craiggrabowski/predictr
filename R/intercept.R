#' @include predictr.R
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
  }
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
as.function.Intercept <- function(x, ...) {
  function(df) {
    matrix(x@data,
           nrow = nrow(df),
           ncol = length(x@data),
           byrow = TRUE
    )
  }
}
