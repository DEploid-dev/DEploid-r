#/bin/bash
cat dEploid-Arguments.Rmd.src > dEploid-Arguments.Rmd
echo "" >> dEploid-Arguments.Rmd
cat ../.DEploid/docs/Bug-report.md >> dEploid-Arguments.Rmd
echo "" >> dEploid-Arguments.Rmd
cat ../.DEploid/docs/Citing-DEploid.md >> dEploid-Arguments.Rmd
