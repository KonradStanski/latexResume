# This Script watches the current directory for changes
# will run the code in the while loop if something changes

#!/bin/sh
okular latexResume.pdf &

while inotifywait -q -r -e modify ./; do
	pdflatex -jobname=latexResume resume.tex
	rm -f *.log
	rm -f *.aux
	rm -f *.xml
	rm -f *.bcf
	rm -f *.out
done
