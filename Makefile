TEXFILE=report

$(TEXFILE).pdf: $(TEXFILE).tex
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)
	bibtex $(TEXFILE)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

clean:
	del *.aux *.blg *.out *.bbl *.log *.pdf *.xml report-blx.bib