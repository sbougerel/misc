#
# Sylvain Bougerel
#

LATEX=latex
PDF_LATEX=pdflatex
VIEWER=evince

LATEX_OPTION=
PDF_LATEX_OPTION=

CLEAN=*.log *.pdf

BASEFILE=cv-us
TEX=$(BASEFILE).tex
PDF=$(BASEFILE).pdf

INCLUDE=res.cls

# Target
preview: $(PDF)
	$(VIEWER) $(PDF)

$(PDF): $(TEX) $(INCLUDE)
	$(PDF_LATEX) $(PDF_LATEX_OPTION) $(TEX)

clean:
	rm -f $(CLEAN)

proper: clean preview
