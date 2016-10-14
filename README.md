<img src="extra/deploid.png" width="180">
[![Build Status](https://travis-ci.org/mcveanlab/DEploid-r.svg?branch=master)](https://travis-ci.org/mcveanlab/DEploid-r)
[![Build Status](https://ci.appveyor.com/api/projects/status/hi1nq97d5l68qs4r?svg=true)](https://ci.appveyor.com/project/shajoezhu/deploid-r)

DEploid R package
=================

`dEploid` is designed for deconvoluting mixed genomes with unknown proportions. Traditional ‘phasing’ programs are limited to diploid organisms. Our method modifies Li and Stephen’s algorithm with Markov chain Monte Carlo (MCMC) approaches, and builds a generic framework that allows haloptype searches in a multiple infection setting.


Installation
------------

Please install `Rcpp` package first. From the `R`-console, type
```R
> install.packages("Rcpp")
```

On specific operating systems, please carry out the following:

### Unix-like system

```R
> install.packages("DEploid_0.3.1.tar.gz", repos=NULL)
```

### Windows

Please first install [https://cran.r-project.org/bin/windows/Rtools/](`Rtools`), then
```R
> install.packages("DEploid_0.3.1.tar.gz", repos=NULL)
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

