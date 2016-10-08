#include <Rcpp.h>

#include <iostream>
#include <fstream>
#include <memory>

#include "DEploid/mcmc.hpp"
#include "DEploid/panel.hpp"
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
//' plafFile = system.file("extdata", "labStrains.test.PLAF.txt", package = "DEploid")
//' vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
//' panelFile = system.file("extdata", "labStrains.test.panel.txt", package = "DEploid")
//' dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-o PG0390-CNopanel -noPanel"))
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

    Panel *panel = NULL; // Move panel to dEploidIO

    if ( dEploidIO.usePanel() ){
        panel = new Panel();
        panel->readFromFile(dEploidIO.panelFileName_.c_str());
        if ( dEploidIO.excludeSites() ){
            panel->findAndKeepMarkers( dEploidIO.excludedMarkers );
        }

        panel->computeRecombProbs( dEploidIO.averageCentimorganDistance(), dEploidIO.Ne(), dEploidIO.useConstRecomb(), dEploidIO.constRecombProb(), dEploidIO.forbidCopyFromSame() );
        panel->checkForExceptions( dEploidIO.nLoci(), dEploidIO.panelFileName_ );
    }

    McmcSample * mcmcSample = new McmcSample();

    McmcMachinery mcmcMachinery(&dEploidIO, panel, mcmcSample);
    mcmcMachinery.runMcmcChain();

    //dEploidIO.write(mcmcSample, panel);

    if ( panel ){
        delete panel;
    }
    delete mcmcSample;

    /** Clean up */
    return List::create(_("version") = VERSION);
}
