TEXFILE= report

$(TEXFILE).pdf: $(TEXFILE).tex
	pdflatex $(TEXFILE)
	
clean:
	del $(TEXFILE).log $(TEXFILE).pdf *.synctex.gz $(TEXFILE).aux