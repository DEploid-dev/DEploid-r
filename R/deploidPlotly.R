
#' @title Plot coverage
#'
#' @description Plot alternative allele count vs reference allele count at each
#'  site.
#'
#' @param ref Numeric array of reference allele count.
#'
#' @param alt Numeric array of alternative allele count.
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile = system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile = system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT = extractCoverageFromTxt(refFile, altFile)
#' plotAltVsRef(PG0390CoverageT$refCount, PG0390CoverageT$altCount)
#'
#' # Example 2
#' vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV = extractCoverageFromVcf(vcfFile)
#' plotAltVsRefPlotly(PG0390CoverageV$refCount, PG0390CoverageV$altCount)
#'

plotAltVsRefPlotly <- function (ref, alt){
  ratios <- ref/(ref + alt + 0.0000001)
  tmpRange <- 1.1 * mean(max(alt), max(ref))
  legend.name <- "Ref/(Ref+Alt) Ratio"
  plot_ly(x = ref, y = alt, type = "scatter", mode = "markers",
          color = ~ ratios, colors=c("#de2d26", "#2b8cbe"), alpha = 0.8,
          marker = list(size = 3, line = list(color = "black", width = 0.3),
                        colorbar = list(title = legend.name)
          ),
          text = paste("RefCount: ", ref, " ;  ", "AltCount: ", alt)) %>%
    layout(margin = list(l = 65, r = 25, b = 50, t = 80, pad = 0),
           title = "Alt vs Ref", font = list(size = 18, colot = "black"),
           legend = list(font = list(size = 5)),
           xaxis = list(title = "Reference # Reads", range = c(-5, 200),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")),
           yaxis = list(title = "Alternative # Reads", range = c(-10, 200),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")),
           shapes = list(list(type = "line", fillcolor = "black", 
                              line = list(color = "black", width = 1.2, 
                                          dash = "dot"), opacity = 0.8, x0 = 50, 
                              x1 = 50, y0 = 0, y1 = 200),
                         list(type = "line", fillcolor = "black", 
                              line = list(color = "black", width = 1.2, 
                                          dash = "dot"), opacity = 0.8, x0 = 0, 
                              x1 = 200, y0 = 50, y1 = 50),
                         list(type = "line", fillcolor = "grey", 
                              line = list(color = "grey", width = 2.5, 
                                          dash = "dot"), opacity = 0.8, x0 = 0, 
                              x1 = 200, y0 = 0, y1 = 200))
    )
}
  

#' @title WSAF histogram
#'
#' @description Produce histogram of the allele frequency within sample.
#'
#' @param obsWSAF Observed allele frequency within sample
#'
#' @param title Histogram title
#' 
#' @return histogram
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile = system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile = system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390Coverage = extractCoverageFromTxt(refFile, altFile)
#' obsWSAF = computeObsWSAF(PG0390Coverage$altCount, PG0390Coverage$refCount)
#' plotHistWSAFPlotly(obsWSAF)
#' myhist = plotHistWSAFPlotly(obsWSAF, FALSE)
#'
#' # Example 2
#' vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV = extractCoverageFromVcf(vcfFile)
#' obsWSAF = computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' plotHistWSAFPlotly(obsWSAF)
#' myhist = plotHistWSAFPlotly(obsWSAF, FALSE)
#'

plotHistWSAFPlotly <- function ( obsWSAF, exclusive = TRUE,
                                   title ="Histogram 0<WSAF<1",
                                   cex.lab = 1, cex.main = 1, cex.axis = 1 ){
  tmpWSAFIndex <- 1:length(obsWSAF)
  if ( exclusive ){
    tmpWSAFIndex <- which( ( (obsWSAF < 1) * (obsWSAF > 0) ) == 1)
  }
  xb = list(
    start = 0,
    end = 1,
    size = 0.1)
  return (plot_ly(x = obsWSAF[tmpWSAFIndex], 
                  type = "histogram", 
                  xbins = xb, 
                  marker = list(color = "#5f9fe8", 
                                line = list(color = "white", width = 1))) %>%
            layout(margin = list(l = 65, r = 25, b = 50, t = 80, pad = 0),
                   title = "Histogram 0<WSAF<1", 
                   font = list(size = 18, colot = "black"),
                   xaxis = list(title = "WSAF", range = c(0,1), 
                                titlefont = list(size = 18, color = "black"),
                                tickfont = list(size = 14, color = "black")),
                   yaxis = list(title = "Frequency", 
                                titlefont = list(size = 18, color = "black"),
                                tickfont = list(size = 14, color = "black"))))
}


#' @title Plot WSAF vs PLAF
#'
#' @description Plot allele frequencies within sample against population level.
#'
#' @param plaf Numeric array of population level allele frequency.
#'
#' @param obsWSAF Numeric array of observed altenative allele frequencies within
#'  sample.
#'
#' @param ref Numeric array of reference allele count.
#'
#' @param alt Numeric array of alternative allele count.
#'
#' @param title Figure title, "WSAF vs PLAF" by default
#'
#' @export
#'
#' @examples
#' # Example 1
#' refFile = system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
#' altFile = system.file("extdata", "PG0390-C.test.alt", package = "DEploid")
#' PG0390CoverageT = extractCoverageFromTxt(refFile, altFile)
#' obsWSAF = computeObsWSAF(PG0390CoverageT$altCount, PG0390CoverageT$refCount)
#' plafFile = system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid")
#' plaf = extractPLAF(plafFile)
#' plotWSAFvsPLAF(plaf, obsWSAF, PG0390CoverageT$refCount, 
#'                PG0390CoverageT$altCount)
#'
#' # Example 2
#' vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV = extractCoverageFromVcf(vcfFile)
#' obsWSAF = computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' plafFile = system.file("extdata", "labStrains.test.PLAF.txt",
#'   package = "DEploid")
#' plaf = extractPLAF(plafFile)
#' plotWSAFvsPLAF(plaf, obsWSAF, PG0390CoverageV$refCount, 
#'                PG0390CoverageV$altCount)
#'

plotWSAFVsPLAFplotly <- function (plaf, obsWSAF, ref, alt){
  plot_ly(x = plaf, y = obsWSAF, type = "scatter", mode = "markers",
          marker = list(size = 2,
                        color = "#c64343",
                        line = list(color = "rgba(152, 0, 0, .8)",
                                    width = 1)),
          text = paste("RefCount: ", ref, " ;  ", "AltCount: ", alt)) %>%
    layout(margin = list(l = 65, r = 25, b = 50, t = 80, pad = 0),
           title = "WSAF vs PLAF", font = list(size = 18, colot = "black"),
           xaxis = list(title = "PLAF", range = c(0,1),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")),
           yaxis = list(title = "WSAF", range = c(0,1),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")))
  # if (length(expWSAF) > 0){
  #   points (plaf, expWSAF, cex = 0.5, col = "blue")
  # }
  # if (length(potentialOutliers) > 0){
  #   points(plaf[potentialOutliers], obsWSAF[potentialOutliers], 
  #          col="black", pch="x", cex = 2)
  # }
}


#' @title Plot WSAF
#'
#' @description Plot observed alternative allele frequency within sample against
#'  expected WSAF.
#'
#' @param obsWSAF Numeric array of observed WSAF.
#'
#' @param expWSAF Numeric array of expected WSAF.
#'
#' @param title Figure title.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
#' PG0390CoverageV = extractCoverageFromVcf(vcfFile)
#' obsWSAF = computeObsWSAF(PG0390CoverageV$altCount, PG0390CoverageV$refCount)
#' plafFile = system.file("extdata", "labStrains.test.PLAF.txt",
#'  package = "DEploid")
#' PG0390CoverageV.deconv = dEploid(paste("-vcf", vcfFile,
#'                                        "-plaf", plafFile, "-noPanel"))
#'                                        
#' prop = PG0390CoverageV.deconv$Proportions[dim(PG0390CoverageV.deconv
#'                                               $Proportions)[1],]
#'                                               
#' expWSAF = t(PG0390CoverageV.deconv$Haps) %*% prop
#' plotObsExpWSAFPlotly(obsWSAF, expWSAF)
#' }
#'

plotObsExpWSAFPlotly <- function (obsWSAF, expWSAF){
  compare = data.frame(obsWSAF, expWSAF)
  plot_ly(compare, x = ~obsWSAF, y = ~expWSAF, type = "scatter", 
          mode = "markers", marker = list(color = "blue", size = 3)) %>%
    layout(margin = list(l = 65, r = 25, b = 50, t = 80, pad = 0),
           title = "WSAF(observed vs expected)", 
           font = list(size = 18, colot = "black"),
           xaxis = list(title = "Observed WSAF (ALT/(ALT+REF))", range = c(0,1),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")),
           yaxis = list(title = "Expected WSAF (h%*%p)", range = c(0,1),
                        titlefont = list(size = 18, color = "black"),
                        tickfont = list(size = 16, color = "black")),
           shapes = list(list(type = "line", fillcolor = "black", 
                              line = list(color = "black", 
                                          width = 1.2, dash = "dot"),
                              opacity = 0.8, x0 = 0, x1 = 1, y0 = 0, y1 = 1)))
}










