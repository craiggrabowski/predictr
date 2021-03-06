% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linear.R
\name{linear}
\alias{linear}
\title{Returns a linear object}
\usage{
linear(x, data = 0)
}
\arguments{
\item{x}{Name of object}

\item{data}{vector (defaults to 0)}
}
\description{
\code{linear} returns an linear object.
}
\details{
A linear object corresponds with the most common type of
summand in a linear-based model,
namely one equal to a parameter \eqn{a} times the value of a
covariate \eqn{x}.
The summand has the following form:

\eqn{a * x}

In the case of a univariate model,
\eqn{a} is a scalar.
For multivariate models,
\eqn{a} is a vector.

Specifying the linear object requires two data elements.
The first element, \code{x},
is the name of the field associated with the covariate.
This name indicates how to identify the covariate in a table
of data.
The second element,
\code{data},
is the parameter,
which can be a scalar or a vector.
}
