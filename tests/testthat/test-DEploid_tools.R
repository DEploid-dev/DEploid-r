context("DEploid tools")

vcfFileName <- system.file("extdata", "PG0390-C.test.vcf.gz",
    package = "DEploid")
plafFileName <- system.file("extdata", "labStrains.test.PLAF.txt",
    package = "DEploid")
panelFileName <- system.file("extdata", "labStrains.test.panel.txt",
    package = "DEploid")
refFileName <- system.file("extdata", "PG0390-C.test.ref", package = "DEploid")
altFileName <- system.file("extdata", "PG0390-C.test.alt", package = "DEploid")

PG0390CoverageVcf <- extractCoverageFromVcf(vcfFileName)
plaf <- extractPLAF(plafFileName)

PG0390Deconv <- dEploid(paste("-vcf", vcfFileName, "-plaf", plafFileName,
    "-noPanel"))
prop <- PG0390Deconv$Proportions[dim(PG0390Deconv$Proportions)[1], ]
expWSAF <- t(PG0390Deconv$Haps) %*% prop

test_that("Extracted coverage", {
    PG0390CoverageTxt <- extractCoverageFromTxt(refFileName, altFileName)
    expect_that(PG0390CoverageTxt, is_a("data.frame"))
    expect_that(PG0390CoverageVcf, is_a("data.frame"))
    expect_equal(PG0390CoverageTxt, PG0390CoverageVcf)
})


test_that("Extracted plaf", {
    expect_that(plaf, is_a("numeric"))
})


test_that("computeObsWSAF", {
    expect_equal(computeObsWSAF(0, 0), 0)
    expect_equal(computeObsWSAF(0, 100), 0)
    expect_equal(computeObsWSAF(1, 99), 0.01)
    expect_equal(computeObsWSAF(99, 1), 0.99)
    expect_equal(computeObsWSAF(50, 50), 0.5)
    expect_equal(computeObsWSAF(50, 100), 0.3333333333333)
})


test_that("WSAF Related", {
    obsWSAF <- computeObsWSAF(PG0390CoverageVcf$altCount,
        PG0390CoverageVcf$refCount)
    expect_that(histWSAF(obsWSAF), is_a("histogram"))
    expect_null(plotWSAFvsPLAF(plaf, obsWSAF))
    expect_null(plotWSAFvsPLAF(plaf, obsWSAF, expWSAF))
    expect_null(plotObsExpWSAF(obsWSAF, expWSAF))
})


test_that("plotAltVsRef", {
    expect_null(plotAltVsRef(PG0390CoverageVcf$refCount,
        PG0390CoverageVcf$altCount))
})


test_that("plotProportion", {
    expect_that(plotProportions(PG0390Deconv$Proportions, ""), is_a("numeric"))
})
