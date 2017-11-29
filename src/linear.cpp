#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix accumulate_linear_cpp(
    NumericMatrix m, NumericVector parameters, NumericVector v) {
  int r = m.nrow();
  int c = m.ncol();

  for (int j = 0; j < c; ++j) {
    double x = parameters[j];
    for (int i = 0; i < r; ++i) {
      m(i,j) += v[i] * x;
    }
  }
  return m;
}



/*** R

*/
