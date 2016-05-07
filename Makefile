TEXFILE=report

$(TEXFILE).pdf: $(TEXFILE).tex
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)
	bibtex $(TEXFILE)
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

clean:
	del *.aux *.blg *.out *.bbl *.log *.pdf report.run.xml report-blx.bib
	
cleanResource:
	cd resources && del *.png *.jp2

cleanExample:
	cd resources/example && del *.png *.jp2
	
cleanImg:
	make cleanResource && make cleanExample