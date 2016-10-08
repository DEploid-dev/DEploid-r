/*
 * dEploid is used for deconvoluting Plasmodium falciparum genome from
 * mix-infected patient sample.
 *
 * Copyright (C) 2016, Sha (Joe) Zhu, Jacob Almagro and Prof. Gil McVean
 *
 * This file is part of dEploid.
 *
 * dEploid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include <Rcpp.h>

#include <iostream>
#include <fstream>
#include <memory>

#include "r_random_generator.hpp"
#include "r_convert_dEploid.hpp"

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

    std::shared_ptr<FastFunc> ff = std::make_shared<FastFunc>();
    RRandomGenerator* rrg = new RRandomGenerator();

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

    McmcMachinery mcmcMachinery(&dEploidIO, panel, mcmcSample, rrg);
    mcmcMachinery.runMcmcChain( false );

    //dEploidIO.write(mcmcSample, panel);
// Need to return mcmc samples for haps, props, llks, as the list members....


    if ( panel ){
        delete panel;
    }
    delete mcmcSample;
    rrg->clearFastFunc();
    delete rrg;
    /** Clean up */
    return List::create(_("version") = VERSION);
}
