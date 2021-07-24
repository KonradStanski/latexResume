# This Script watches the current directory for changes
# will run the code in the while loop if something changes

#!/bin/sh
outname = "EditThisInLiveReload"

while inotifywait -q -r -e modify ./; do
	pdflatex -jobname=$outname \
	-halt-on-error \
	resume.tex
	rm -f ../*.log
	rm -f ../*.aux
	rm -f ../*.xml
	rm -f ../*.bcf
	rm -f ../*.out
done
