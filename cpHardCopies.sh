#!/bin/bash

# dEploidTools.r
#rsync -av .DEploid/utilities/DEploidR.R R/DEploidR.R
rsync -avu R/DEploidR.R .DEploid/utilities/DEploidR.R

# cpp
#rsync -avu src/DEploid/ .DEploid/src/

# sync from DEploid to DEploid-r
rsync -avu .DEploid/src/*pp src/DEploid/
rsync -avu .DEploid/src/codeCogs/ src/DEploid/codeCogs/
rsync -avu .DEploid/src/debug/ src/DEploid/debug/
rsync -avu .DEploid/src/export/ src/DEploid/export/
rsync -avu .DEploid/src/gzstream/ src/DEploid/gzstream/
rsync -avu .DEploid/src/random/ src/DEploid/random/
rsync -avu .DEploid/src/lasso/*pp src/DEploid/lasso/
rsync -avu .DEploid/src/lasso/*pp src/DEploid/lasso/src/

# tidy up
#rm -r src/DEploid/*/.deps
#rm -r src/DEploid/*/.dirstamp
#rm -r src/DEploid/*gcda
#rm -r src/DEploid/*gcno
#rm -r src/DEploid/*/*gcda
#rm -r src/DEploid/*/*gcno
