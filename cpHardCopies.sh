#!/bin/bash

# dEploidTools.r
cp .DEploid/utilities/dEploidTools.r R/dEploidTools.R

# cpp
cp -r .DEploid/src/* src/DEploid/

# tidy up
rm -r src/DEploid/*/.deps
rm -r src/DEploid/*/.dirstamp
rm -r src/DEploid/*gcda
rm -r src/DEploid/*gcno
rm -r src/DEploid/*/*gcda
rm -r src/DEploid/*/*gcno
