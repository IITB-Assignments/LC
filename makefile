FILES := report.pdf
AUXFILES := $(FILES:.pdf=.aux)
LOGFILES := $(FILES:.pdf=.log)
BBLFILES := $(FILES:.pdf=.bbl)
BLGFILES := $(FILES:.pdf=.blg)
OTHERS := mass_spring_damper.nav mass_spring_damper.out mass_spring_damper.snm mass_spring_damper.toc
PICS := $(wildcard *.png)
PICSDEL := $(filter-out RLC_series_circuit.png,$(PICS))
PYC := $(wildcard *.pyc)

main : main.py
	python main.py
	make pdf

pdf : $(FILES:.pdf=.tex)
	make report.pdf

%.pdf: %.tex 
	pdflatex $<
	bibtex `echo $< |cut -d "." -f1`.aux
	pdflatex $<
	pdflatex $<

.PHONY: clean clean-all
clean-all:
	$(RM) $(AUXFILES) $(FILES) $(LOGFILES) $(BBLFILES) $(BLGFILES) $(OTHERS) $(PICSDEL) $(PYC)

clean:	 
	$(RM) $(AUXFILES) $(LOGFILES) $(BBLFILES) $(BLGFILES) $(OTHERS) $(PICSDEL) $(PYC)

