#!/bin/bash
# Building package
R CMD build  .

PKG_TARBALL=dEploid_0.3.tar.gz
# Checking package
R CMD check "${PKG_TARBALL}" --as-cran; CHECK_RET=$?

# R CMD check fail logs
$ for name in $(find "${RCHECK_DIR}" -type f -name "*fail");do echo ">>> Filename: ${name} <<<";cat ${name};done

# R CMD check log logs
$ for name in $(find "${RCHECK_DIR}" -type f -name "*log");do echo ">>> Filename: ${name} <<<";cat ${name};done

# R CMD check out logs
$ for name in $(find "${RCHECK_DIR}" -type f -name "*out");do echo ">>> Filename: ${name} <<<";cat ${name};done

