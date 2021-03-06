% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dEploidPlotly.R
\name{plotWSAFVsPLAFPlotly}
\alias{plotWSAFVsPLAFPlotly}
\title{Plot WSAF vs PLAF}
\usage{
plotWSAFVsPLAFPlotly(
  plaf,
  obsWSAF,
  ref,
  alt,
  title = "WSAF vs PLAF",
  potentialOutliers = c()
)
}
\arguments{
\item{plaf}{Numeric array of population level allele frequency.}

\item{obsWSAF}{Numeric array of observed altenative allele frequencies within
sample.}

\item{ref}{Numeric array of reference allele count.}

\item{alt}{Numeric array of alternative allele count.}

\item{title}{Figure title, "WSAF vs PLAF" by default}

\item{potentialOutliers}{Index of potential outliers.}
}
\description{
Plot allele frequencies within sample against population level.
}
\examples{
# Example 1
refFile = system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
altFile = system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
PG0390CoverageT = extractCoverageFromTxt(refFile, altFile)
obsWSAF = computeObsWSAF(PG0390CoverageT$altCount, PG0390CoverageT$refCount)
plafFile = system.file("extdata", "labStrains.test.PLAF.txt",
  package = "DEploid")
plaf = extractPLAF(plafFile)
plotWSAFVsPLAFPlotly(plaf, obsWSAF, PG0390CoverageT$refCount,
               PG0390CoverageT$altCount)

# Example 2
vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
PG0390CoverageV = extractCoverageFromVcf(vcfFile)
obsWSAF = computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
plafFile = system.file("extdata", "labStrains.test.PLAF.txt",
  package = "DEploid")
plaf = extractPLAF(plafFile)
plotWSAFVsPLAFPlotly(plaf, obsWSAF, PG0390CoverageV$refCount,
               PG0390CoverageV$altCount)

}
