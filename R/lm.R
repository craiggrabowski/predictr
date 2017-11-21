#' @include intercept.R
#' @include linear.R
#' @include lookup.R
NULL

lm_intercept_string <- "(Intercept)"

as.intercept_list.lm <- function(x, ...) {
  y <- coef(x)
  if (!(lm_intercept_string %in% names(y)))
    return(list())

  n <- which(names(y) == lm_intercept_string)
  n <- y[n]
  names(n) <- NULL
  list(intercept(n))
}

as.linear_list.lm <- function(x, ...) {
  t <- attr(terms(x), "dataClasses")[-1L]
  I <- t %in% c("numeric", "integer")

  y <- coef(x)
  J <- match(names(y), names(t)[I])
  y <- y[!is.na(J)]

  lapply(seq_along(y), function(i)
    linear(names(y)[i], y[i])
  )
}

as.lookup_list.lm <- function(x, ...) {
  t <- attr(terms(x), "dataClasses")[-1L]
  I <- t %in% c("character", "factor")
  v <- coef(x)

  lapply(names(t)[I], function(s) {
    levels <- x$xlevels[[s]]
    m <- matrix(0, ncol = 1L, nrow = length(levels))
    pattern <- paste0("^", s)
    J <- grepl(pattern, names(v))
    K <- gsub(pattern, "", names(v)[J])
    L <- match(K, levels)
    m[L,] <- v[J]

    lookup(x = s, data = m, levels = levels)
  })

}
