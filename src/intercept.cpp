#include <Rcpp.h>
#include <iterator>
#include <algorithm>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector originate_intercept_cpp(
    int r, NumericVector parameters) {
  int c = parameters.length();
  NumericMatrix m(r, c);

  NumericMatrix::iterator begin = m.begin();
  NumericMatrix::iterator end = begin;
  std::advance(end, r);

  NumericVector::const_iterator pb = parameters.cbegin();
  NumericVector::const_iterator pe = parameters.cend();

  for (; pb < pe; ++pb) {
    std::fill(begin, end, *pb);
    begin = end;
    std::advance(end, r);
  }

  return m;
}

/*** R

*/
