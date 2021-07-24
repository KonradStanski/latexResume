# Simple makefile

TARGET := EditMeInMakeFile

$(TARGET):
	@cd src; \
	pdflatex -jobname=$(TARGET) \
	-halt-on-error \
	resume.tex \
	> /dev/null
	@make clean

.PHONY: live
live:
	@cd src; \
	./livereload.sh > /dev/null

.PHONY: clean
clean:
	@rm -rf *.log *.aux *.xml *.bcf *.out *.gz *.fls *.bbl *.blg *.fdb_latexmk resume.pdf
	@cd src; \
	rm -rf *.log *.aux *.xml *.bcf *.out *.gz *.fls *.bbl *.blg *.fdb_latexmk resume.pdf

.PHONY: get-dep
get-dep:
	sudo apt-get -y update
	sudo apt install -y biber
	sudo apt install -y texlive-latex-base
	sudo apt-get -y install texlive-full
	sudo apt install -y inotify-tools
