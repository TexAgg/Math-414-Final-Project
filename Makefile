TEXFILE= report
$(TEXFILE).pdf: $(TEXFILE).tex
	pdflatex $(TEXFILE)
	
clean:
	del report.log report.pdf *.synctex.gz report.aux