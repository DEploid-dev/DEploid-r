if (require("testthat")) {
  test_check("DEploid")
} else {
  warning("testthat not available. Skipping unittests!")
}

#library("testthat")
#library("DEploid")
#test_check("DEploid")
