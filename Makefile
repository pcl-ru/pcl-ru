PDFLATEX = pdflatex

PNAME=pcl-ru

LOCALE=ru_RU.koi8r

.PHONY: all
all: $(PNAME).pdf

#$(PNAME).ind: $(PNAME).idx
#	makeindex -s pcl-ru.ids $(PNAME)

$(PNAME).pdf: *.tex Makefile #$(PNAME).bbl 
#	$(PDFLATEX) $(PNAME)
#	make $(PNAME).ind
	$(PDFLATEX) $(PNAME)
	while grep 'Label(s) may have changed' $(PNAME).log > /dev/null 2>&1 ; do \
		$(PDFLATEX) $(PNAME) ; \
	done

.PHONY: stat
stat:
	@echo "Overfulls: `grep ^Overfull pcl-ru.log | wc -l`"
	@echo "Underfulls: `grep ^Underfull pcl-ru.log | wc -l`"

$(PNAME).bbl: $(PNAME).bib *.tex
	      $(PDFLATEX) -draftmode $(PNAME)
	      bibtex $(PNAME)
	      $(PDFLATEX) -draftmode $(PNAME)
	      bibtex $(PNAME)

$(PNAME).html: *.tex
	hevea -fix $(PNAME).tex 
	hacha -o $(PNAME)-toc.html $(PNAME).html

clean:; rm -f *.aux *.lof *.log *.lot $(PNAME).bbl *.dvi $(PNAME).blg *.toc $(PNAME).pdf l[0-9]*.pdf \
	$(PNAME).idx $(PNAME).ilg $(PNAME).ind $(PNAME).out

