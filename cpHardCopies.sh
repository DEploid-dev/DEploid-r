#!/bin/bash

# dEploidTools.r
#rsync -av .DEploid/utilities/DEploidR.R R/DEploidR.R
rsync -avu R/DEploidR.R .DEploid/utilities/DEploidR.R

# cpp
#rsync -avu src/DEploid/ .DEploid/src/

# sync from DEploid to DEploid-r
rsync -avu .DEploid/src/ src/DEploid/

# tidy up
#rm -r src/DEploid/*/.deps
#rm -r src/DEploid/*/.dirstamp
#rm -r src/DEploid/*gcda
#rm -r src/DEploid/*gcno
#rm -r src/DEploid/*/*gcda
#rm -r src/DEploid/*/*gcno
