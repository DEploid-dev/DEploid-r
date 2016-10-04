#include <Rcpp.h>

#include <iostream>
#include <fstream>
#include <memory>

#include "DEploid/dEploidIO.hpp"
#include "DEploid/random/fastfunc.hpp"


using namespace Rcpp;
//std::ofstream fs;
//bool write_file;


// [[Rcpp::plugins(cpp11)]]

//' Deconvolute mixed haplotypes, and reporting the mixture proportions from each sample
//' This function provieds an interface for calling \emph{dEploid} from R.
//' The command line options are passed via the \code{args} argument and \code{file}
//'
//' @section blahblah:
//' Blah blah
//'
//' @param args blah blah blah
//'
//' @param file blah blah blah
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
//'
// [[Rcpp::export]]
List dEploid(std::string args, std::string file = "") {

    /** Parse args and generate the model */
    DEploidIO dEploidIO(args);

    //// Print help or version information if user asked for it
    if ( dEploidIO.version() ){
        return List::create(_("version") = VERSION);
    }

    if ( dEploidIO.help() ){
        stop("Please use '?dEploid' for help");
    }

    ///** Throw a warning if -seed argmuent is used */
    if (dEploidIO.randomSeedWasSet()){
      Rf_warning("Ignoring seed argument. Set a seed in R.");
    }

    /** Clean up */
    return List::create(_("version") = VERSION);
}
