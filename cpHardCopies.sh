#!/bin/bash

# dEploidTools.r
#rsync -av .DEploid/utilities/dEploidTools.r R/dEploidTools.R
rsync -avu  R/dEploidTools.R .DEploid/utilities/dEploidTools.r

# cpp
rsync -avu src/DEploid/ .DEploid/src/

# tidy up
#rm -r src/DEploid/*/.deps
#rm -r src/DEploid/*/.dirstamp
#rm -r src/DEploid/*gcda
#rm -r src/DEploid/*gcno
#rm -r src/DEploid/*/*gcda
#rm -r src/DEploid/*/*gcno
