#!/usr/bin/env Rscript

lintr::lint_package()
covr::coveralls(line_exclusions = c("R/RcppExports.R",
                                    "src/RcppExports.cpp",
                                    list.files("src/DEploid",
                                               recursive = TRUE,
                                               full.names = TRUE)))

