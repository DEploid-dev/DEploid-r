#' @importFrom DEploid.utils extractCoverageFromTxt
#' @title Extract read counts from plain text file
#'
#' @note The allele count files must be tab-delimited. The allele count files
#'  contain three columns: chromosomes, positions and allele count.
#'
#' @param refFileName Path of the reference allele count file.
#'
#' @param altFileName Path of the alternative allele count file.
#'
#' @return A data.frame contains four columns: chromosomes, positions, reference
#'  allele count, alternative allele count.
#'
#' @export
#'
#' @examples
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390 <- extractCoverageFromTxt(refFile, altFile)
#'
DEploid.utils::extractCoverageFromTxt


#' @importFrom DEploid.utils extractCoverageFromVcf
#' @title Extract read counts from VCF
#'
#' @note The VCF file should only contain one sample. If more samples present in
#'  the VCF, it only returns coverage for of the first sample.
#'
#' @param vcfFileName Path of the VCF file.
#'
#' @param ADFieldIndex Index of the AD field of the sample field. For example,
#'  if the format is "GT:AD:DP:GQ:PL", the AD index is 2 (by default).
#'
#' @return A data.frame contains four columns: chromosomes, positions, reference
#'  allele count, alternative allele count.
#'
#' @export
#'
#' @examples
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390 <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#'
DEploid.utils::extractCoverageFromVcf


#' @importFrom DEploid.utils extractPLAF
#'
#' @title Extract PLAF
#'
#' @note The text file must have header, and population level allele frequency
#'  recorded in the "PLAF" field.
#'
#' @param plafFileName Path of the PLAF text file.
#'
#' @return A numeric array of PLAF
#'
#' @export
#'
#' @examples
#' plafFile <- system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid"
#' )
#' plaf <- extractPLAF(plafFile)
DEploid.utils::extractPLAF


#' @importFrom DEploid.utils plotProportions
#'
#' @title Plot proportions
#'
#' @param proportions Matrix of the MCMC proportion samples. The matrix size is
#'  number of the MCMC samples by the number of strains.
#'
#' @param title Figure title.
#'
#' @param cex.lab Label size.
#'
#' @param cex.main Title size.
#'
#' @param cex.axis Axis text size.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' plafFile <- system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid"
#' )
#' panelFile <- system.file("extdata", "labStrains.test.panel.txt",
#'   package = "DEploid"
#' )
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT <- extractCoverageFromTxt(refFile, altFile)
#' PG0390Coverage.deconv <- dEploid(paste(
#'   "-ref", refFile, "-alt", altFile,
#'   "-plaf", plafFile, "-noPanel"
#' ))
#' plotProportions(PG0390Coverage.deconv$Proportions, "PG0390-C proportions")
#' }
#'
DEploid.utils::plotProportions


#' @importFrom DEploid.utils plotAltVsRef
#'
#' @title Plot coverage
#'
#' @param ref Numeric array of reference allele count.
#'
#' @param alt Numeric array of alternative allele count.
#'
#' @param title Figure title, "Alt vs Ref" by default
#'
#' @param exclude.ref Numeric array of reference allele count at sites that are
#' not deconvoluted.
#'
#' @param exclude.alt Numeric array of alternative allele count at sites that
#'  are not deconvoluted
#'
#' @param potentialOutliers Index of potential outliers.
#'
#' @param cex.lab Label size.
#'
#' @param cex.main Title size.
#'
#' @param cex.axis Axis text size.
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT <- extractCoverageFromTxt(refFile, altFile)
#' plotAltVsRef(PG0390CoverageT$refCount, PG0390CoverageT$altCount)
#'
#' # Example 2
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#' plotAltVsRef(PG0390CoverageV$refCount, PG0390CoverageV$altCount)
#'
DEploid.utils::plotAltVsRef


#' @importFrom DEploid.utils histWSAF
#'
#' @title WSAF histogram
#'
#' @param obsWSAF Observed allele frequency within sample
#'
#' @param exclusive When TRUE 0 < WSAF < 1; otherwise 0 <= WSAF <= 1.
#'
#' @param title Histogram title
#'
#' @param cex.lab Label size.
#'
#' @param cex.main Title size.
#'
#' @param cex.axis Axis text size.
#'
#' @return histogram
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390Coverage <- extractCoverageFromTxt(refFile, altFile)
#' obsWSAF <- computeObsWSAF(PG0390Coverage$altCount, PG0390Coverage$refCount)
#' histWSAF(obsWSAF)
#' myhist <- histWSAF(obsWSAF, FALSE)
#'
#' # Example 2
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#' obsWSAF <- computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' histWSAF(obsWSAF)
#' myhist <- histWSAF(obsWSAF, FALSE)
#'
DEploid.utils::histWSAF


#' @importFrom DEploid.utils plotWSAFvsPLAF
#'
#' @title Plot WSAF vs PLAF
#'
#' @param plaf Numeric array of population level allele frequency.
#'
#' @param obsWSAF Numeric array of observed altenative allele frequencies within
#'  sample.
#'
#' @param expWSAF Numeric array of expected WSAF from model.
#'
#' @param title Figure title, "WSAF vs PLAF" by default
#'
#' @param potentialOutliers Index of potential outliers.
#'
#' @param cex.lab Label size.
#'
#' @param cex.main Title size.
#'
#' @param cex.axis Axis text size.
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT <- extractCoverageFromTxt(refFile, altFile)
#' obsWSAF <- computeObsWSAF(PG0390CoverageT$altCount, PG0390CoverageT$refCount)
#' plafFile <- system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid"
#' )
#' plaf <- extractPLAF(plafFile)
#' plotWSAFvsPLAF(plaf, obsWSAF)
#'
#' # Example 2
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#' obsWSAF <- computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' plafFile <- system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid"
#' )
#' plaf <- extractPLAF(plafFile)
#' plotWSAFvsPLAF(plaf, obsWSAF)
#'
DEploid.utils::plotWSAFvsPLAF


#' @importFrom DEploid.utils plotObsExpWSAF
#'
#' @title Plot WSAF
#'
#' @param obsWSAF Numeric array of observed WSAF.
#'
#' @param expWSAF Numeric array of expected WSAF.
#'
#' @param title Figure title.
#'
#' @param cex.lab Label size.
#'
#' @param cex.main Title size.
#'
#' @param cex.axis Axis text size.
#'
#' @export
#'
#' @examples
#'
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#' obsWSAF <- computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' plafFile <- system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid"
#' )
#' PG0390.deconv <- dEploid(paste(
#'   "-vcf", vcfFile,
#'   "-plaf", plafFile, "-noPanel"
#' ))
#' prop <- PG0390.deconv$Proportions[dim(PG0390.deconv$Proportions)[1], ]
#' expWSAF <- t(PG0390.deconv$Haps) %*% prop
#' plotObsExpWSAF(obsWSAF, expWSAF)
#'
DEploid.utils::plotObsExpWSAF


#' @importFrom DEploid.utils computeObsWSAF
#'
#' @title Compute observed WSAF
#'
#' @param ref Numeric array of reference allele count.
#'
#' @param alt Numeric array of alternative allele count.
#'
#' @return Numeric array of observed allele frequency within sample.
#'
#' @seealso \code{\link{histWSAF}} for histogram.
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT <- extractCoverageFromTxt(refFile, altFile)
#' obsWSAF <- computeObsWSAF(PG0390CoverageT$altCount, PG0390CoverageT$refCount)
#'
#' # Example 2
#' vcfFile <- system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV <- extractCoverageFromVcf(vcfFile, "PG0390-C")
#' obsWSAF <- computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#'
DEploid.utils::computeObsWSAF


#' @importFrom DEploid.utils haplotypePainter
#'
#' @title Painting haplotype according the reference panel
#'
#' @param posteriorProbabilities Posterior probabilities matrix with the size of
#'  number of loci by the number of reference strain.
#'
#' @param title Figure title.
#'
#' @param labelScaling Scaling parameter for plotting.
#'
#' @param numberOfInbreeding Number of inbreeding strains copying from.
#'
#' @export
#'
DEploid.utils::haplotypePainter
