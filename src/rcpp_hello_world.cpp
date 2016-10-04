#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

//' sasfdafdsf asdfsdafa
//'
//' @section blahblah:
//' Blah blah
//'
//' @return A named list of something something ...
//'
//' @export
//'
//' @keywords datagen
//'
//' @examples
//' set.seed(1234)
//'
// [[Rcpp::export]]
List rcpp_hello_world() {
CharacterVector x = CharacterVector::create( "foo", "bar" ) ;
NumericVector y = NumericVector::create( 0.0, 1.0 ) ;
List z = List::create( x, y ) ;
return z ;
}
