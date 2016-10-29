context("dEploid")

vcfFile = system.file("extdata", "PG0390-C.test.vcf.gz", package = "DEploid")
plafFile = system.file("extdata", "labStrains.test.PLAF.txt", package = "DEploid")
panelFile = system.file("extdata", "labStrains.test.panel.txt", package = "DEploid")

test_that("printing help & verison information works", {
  for (version in list(dEploid("-v"), dEploid("-version"))) {
    expect_that(version, is_a("list"))
    expect_that(version$version, is_a("character"))
  }

  expect_error(dEploid("-h"))
  expect_error(dEploid("--help"))
})


test_that("parsing arguments works",
{
  expect_error(dEploid("--version"))
  expect_error(dEploid(paste("-vcf", vcfFile, "-plaf", plafFile)))
  expect_error(dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-panel", panelFile, "-noPanel")))
})


test_that("runs a reproducible",
{
#  set.seed(119)
#  res1 <- dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-noPanel"))
#  set.seed(119)
#  res2 <- dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-noPanel"))
#  expect_equal(res1, res2)

##  set.seed(119)
##  res1 <- dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-panel", panelFile))
##  set.seed(119)
##  res2 <- dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-panel", panelFile))
##  expect_equal(res1, res2)

  }
)

test_that("warning is given when using -seed",
{
#  expect_warning(dEploid(paste("-vcf", vcfFile, "-plaf", plafFile, "-noPanel -seed 1"))
})


