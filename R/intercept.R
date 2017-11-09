#' @include predictr.R
NULL


Intercept <-
setClass("Intercept",
  slots = list(
    data = "numeric"
  )
)

#' Returns an intercept object
#'
#' \code{intercept} returns an intersept object.
#'
#'
#' @param x Intersept vector (default to 0)
#'
#' @export
intercept <- function(x = 0) {
  Intersept(data = as.numeric(x))
}
