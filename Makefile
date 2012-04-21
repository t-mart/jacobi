#no extension
DOCUMENT=report

VIEWER=evince

TOPDF=pdflatex
OPTIONS=-file-line-error -interaction=nonstopmode

default: $(DOCUMENT).tex
	$(TOPDF) $(OPTIONS) $<

%.pdf: %.tex
	$(TOPDF) $(OPTIONS) $<

view: $(DOCUMENT).pdf
	$(VIEWER) $<

html: $(DOCUMENT).tex
	tth $<

archive: default
	tar czvf tim_martin.jacobi_algorithm.tar.gz `git ls-files`

clean:
	#ignore if these files don't exist with -[command]
	-rm *.aux
	-rm *.dvi
	-rm *.log
	-rm *.pdf
