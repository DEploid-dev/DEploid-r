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

#include "mcmc.hpp"
#include "panel.hpp"
#include "dEploidIO.hpp"
#include "fastfunc.hpp"

using namespace Rcpp;
//using namespace std;
//std::ofstream fs;
//bool write_file;

class RMcmcSample {
  private:
    McmcSample * mcmcSample_;
    size_t kStrain_;
    size_t nLoci_;
    size_t nMcmcSample_;

    List resultList_;
    NumericMatrix haps;
    NumericMatrix proportion;
    NumericVector llks;

    void convertHaps(){
        this->haps = NumericMatrix(this->kStrain_,
                                   this->nLoci_);
        for (size_t k = 0; k < this->kStrain_; k++) {
            for (size_t i = 0; i < this->nLoci_; i++) {
                this->haps(k,i) = this->mcmcSample_->hap[i][k];
            }
        }
    }

    void convertProportions(){
        this->proportion = NumericMatrix(this->nMcmcSample_,
                                         this->kStrain_);
        //NumericMatrix res(input[0].size(),input.size());
//double* resp = REAL(this->proportion);
//for (size_t ci = 0; ci < this->proportion.ncol(); ++ci){
    //std::copy(this->mcmcSample_->proportion[ci].begin(), this->mcmcSample_->proportion[ci].end(),resp+ci*this->proportion.nrow());}
        //cout << "this->mcmcSample_->proportion.size() should be "<< this->nMcmcSample_ << ", truth is "<<this->mcmcSample_->proportion.size()<<endl;
    }

    void convertLLKs(){
        this->llks = NumericVector(this->nMcmcSample_, 0.0);
        for (size_t i = 0; i < this->nMcmcSample_; i++) {
            this->llks(i) = this->mcmcSample_->sumLLKs[i];
        }
    }

  public:
    RMcmcSample (DEploidIO* dEploidIO, McmcSample * mcmcSample){
        this->kStrain_ = dEploidIO->kStrain_;
        this->nLoci_ = dEploidIO->plaf_.size();
        this->nMcmcSample_ = dEploidIO->nMcmcSample_;

        this->mcmcSample_ = mcmcSample;
        this->convertHaps();
        this->convertProportions();
        this->convertLLKs();

        resultList_ = List::create(_("Haps") = this->haps,
                                   _("Proportions") = this->proportion,
                                   _("llks") =  this->llks);
    }

    ~RMcmcSample(){}

    List packageResults(){
        return resultList_;
    }
};


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

//cout<< mcmcSample->hap.size() << " x " << mcmcSample->hap[0].size() << endl;
cout<< mcmcSample->proportion.size() << " x " << mcmcSample->proportion[0].size() << endl;

    if ( panel ){
        delete panel;
    }
    delete mcmcSample;
    rrg->clearFastFunc();
    delete rrg;

    //RMcmcSample rMcmcSample(&dEploidIO, mcmcSample);
    /** Finalize */
    size_t kStrain_ = dEploidIO.kStrain();
    size_t nLoci_ = dEploidIO.nLoci();
    size_t nMcmcSample_ = dEploidIO.nMcmcSample();

    NumericMatrix haps = NumericMatrix(nLoci_,kStrain_);
    for (size_t i = 0; i < nLoci_; i++) {
        for (size_t k = 0; k < kStrain_; k++) {
            haps(i,k) = mcmcSample->hap[i][k];
            cout << i << " " <<(int)haps(i,k)<< " " <<(int)mcmcSample->hap[i][k];
        }
        cout<<endl;
    }

    NumericMatrix proportion = NumericMatrix(nMcmcSample_,
                                             kStrain_);
    for (size_t i = 0; i < nMcmcSample_; i++) {
        //cout <<i<<"  "<<mcmcSample->proportion[i].size()<<endl;
        //for (size_t k = 0; k < kStrain_; k++) {
            //proportion(i,k) = mcmcSample->proportion[i][k];
        //}
    }

    NumericVector llks = NumericVector(nMcmcSample_, 0.0);;
    for (size_t i = 0; i < nMcmcSample_; i++) {
        llks(i) = mcmcSample->sumLLKs[i];
    }
    return List::create(_("Haps") = haps,
                        _("Proportions") = proportion,
                        _("llks") =  llks);
}
