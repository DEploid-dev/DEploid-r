<img src="extra/deploid.png" width="180">
[![License (GPL version 3)](https://img.shields.io/badge/license-GPL%20version%203-brightgreen.svg)](http://opensource.org/licenses/GPL-3.0)
[![Build Status](https://travis-ci.org/mcveanlab/DEploid-r.svg?branch=master)](https://travis-ci.org/mcveanlab/DEploid-r)
[![Build Status](https://ci.appveyor.com/api/projects/status/hi1nq97d5l68qs4r?svg=true)](https://ci.appveyor.com/project/shajoezhu/deploid-r)
[![Coverage Status](https://coveralls.io/repos/github/mcveanlab/DEploid-r/badge.svg)](https://coveralls.io/github/mcveanlab/DEploid-r)
[![codecov](https://codecov.io/gh/mcveanlab/DEploid-r/branch/master/graph/badge.svg)](https://codecov.io/gh/mcveanlab/DEploid-r)

DEploid R package
=================

`dEploid` is designed for deconvoluting mixed genomes with unknown proportions. Traditional ‘phasing’ programs are limited to diploid organisms. Our method modifies Li and Stephen’s algorithm with Markov chain Monte Carlo (MCMC) approaches, and builds a generic framework that allows haloptype searches in a multiple infection setting.


Installation
------------

Please install `Rcpp` package first. From the `R`-console, type
```R
> install.packages("Rcpp")
```

###Note: 
If you are using Windows, please install `Rtools` from [https://cran.r-project.org/bin/windows/Rtools/](`Rtools`), then

```R
> install.packages("devtools")
> library(devtools)
> install_github("mcveanlab/DEploid-r")
```

Usage
-----

Please refer to the help page and examples for each function. For example,
```R
> library(DEploid)
> ?dEploid
> ?plotProportions
```

Licence
-------

You can freely use all code in this project under the conditions of the GNU GPL Version 3 or later.


Citation
--------

If you use `dEploid` in your work, please cite the program:

PLACEHOLDER FOR APP NOTE

