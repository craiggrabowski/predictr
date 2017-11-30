#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector originate_intercept_cpp(
    int r, NumericVector parameters) {
  int c = parameters.length();
  NumericMatrix m(r, c);

  for (int j = 0; j < c; ++j) {
    double x = parameters[j];
    for (int i = 0; i < r; ++i) {
      m(i,j) = x;
    }
  }

  return m;
}

/*** R

*/
