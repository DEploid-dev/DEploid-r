#' @keywords internal
"_PACKAGE"

#' Deconvolute Mixed Genomes with Unknown Proportions
#'
#' Traditional phasing programs are limited to diploid organisms.
#' Our method modifies Li and Stephens algorithm with Markov chain Monte Carlo
#' (MCMC) approaches, and builds a generic framework that allows haplotype
#' searches in a multiple infection setting. This package is primarily developed
#' as part of #' the Pf3k project, which is a global collaboration using the
#' latest sequencing technologies to provide a high-resolution view of natural
#' variation in the malaria parasite Plasmodium falciparum. Parasite DNA are
#' extracted from patient blood sample, which often contains more than one
#' parasite strain, with unknown proportions. This package is used for
#' deconvoluting mixed haplotypes, #' and reporting the mixture proportions from
#' each sample.
#'
#' @author
#' Zhu Sha
#'
#' Maintainer: Joe Zhu \email{sha.joe.zhu@gmail.com}
#'
#' @name DEploid-package
#'
#' @importFrom Rcpp evalCpp
#' @importFrom scales alpha
#' @importFrom grDevices rainbow colorRampPalette
#' @importFrom graphics abline barplot hist plot points axis legend
#' @importFrom utils read.table
#' @importFrom magrittr %>%
#' @importFrom plotly plot_ly layout add_trace
#' @importFrom rmarkdown pandoc_available
#' @importFrom htmlwidgets saveWidget
#' @useDynLib DEploid, .registration = TRUE
NULL

