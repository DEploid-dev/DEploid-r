context("DEploid tools")

vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
plafFile = system.file("extdata", "labStrains.test.PLAF.txt", package = "DEploid")
panelFile = system.file("extdata", "labStrains.test.panel.txt", package = "DEploid")
refFile = system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
altFile = system.file("extdata", "PG0390-C.test.alt", package = "DEploid")

test_that("Extracted coverage", {
    PG0390CoverageTxt = extractCoverageFromTxt(refFile, altFile)
    expect_that(PG0390CoverageTxt, is_a("data.frame"))
    PG0390CoverageVcf = extractCoverageFromVcf(vcfFile)
    expect_that(PG0390CoverageVcf, is_a("data.frame"))
    expect_equal(PG0390CoverageTxt, PG0390CoverageVcf)
})


test_that("Extracted plaf", {
    plaf = extractPLAF(plafFile)
    expect_that(plaf, is_a("numeric"))
})


test_that("computeObsWSAF", {
    expect_equal(computeObsWSAF(0, 0), 0)
})
