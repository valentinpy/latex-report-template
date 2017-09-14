## Valentin Py
.DEFAULT_GOAL := pdf_report

#Must be the name of the parent folder
PROJECT_NAME = report

MAIN_NAME_PRESENTATION = main

REPORT_DIR = report
MAIN_NAME_REPORT = main

## COMMANDS:
PDFLATEX_CMD = /usr/local/texlive/2017/bin/x86_64-darwin/pdflatex
#PDFLATEX_CMD = pdflatex
BIBTEX_CMD = biber
MAKEIDX_CMD = makeindex
DATESTAMP = `/bin/date +%Y-%m-%d`
DATESTAMP_AND_PROJECT = ${PROJECTNAME}
PDFVIEWER = open
DIR_LOGO = figures/titlepage_fig/

#help
#helpThe main targets of this Makefile are:
#help	help			this help
.PHONY: help
help:
	@sed -n 's/^#help//p' < Makefile

#help	all			see "pdf"
.PHONY: all
all: pdf_figures pdf_report

#help	pdf_report		makes a file per pdflatex for the report
.PHONY: pdf_report
pdf_report:
	cd ${REPORT_DIR}; ${PDFLATEX_CMD} ${MAIN_NAME_REPORT}.tex; cd -
	cd ${REPORT_DIR}; ${BIBTEX_CMD} ${MAIN_NAME_REPORT}; cd -
	cd ${REPORT_DIR}; ${PDFLATEX_CMD} ${MAIN_NAME_REPORT}.tex; cd -
	cd ${REPORT_DIR}; ${PDFLATEX_CMD} ${MAIN_NAME_REPORT}.tex; cd -

#help	pdf_report_simple	makes a file per pdflatex for the report without bilbio
.PHONY: pdf_report_simple
pdf_report_simple:
	cd ${REPORT_DIR}; ${PDFLATEX_CMD} ${MAIN_NAME_REPORT}.tex; cd -
	cd ${REPORT_DIR}; ${PDFLATEX_CMD} ${MAIN_NAME_REPORT}.tex; cd -

#help	wc			counts the words from the PDF generated of the report
wc:	pdf_report
	pdf2ps ${REPORT_DIR}/${MAIN_NAME_REPORT}.pdf ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps
	ps2ascii  ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps >  ${REPORT_DIR}/${MAIN_NAME_REPORT}.txt
	wc   ${REPORT_DIR}/${MAIN_NAME_REPORT}.txt
	rm ${REPORT_DIR}/${MAIN_NAME_REPORT}.txt
	rm ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps

#help	txt			generate a txt file from the report, can be used for typo checking with antidote
txt:	pdf_report
	pdf2ps ${REPORT_DIR}/${MAIN_NAME_REPORT}.pdf ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps
	ps2ascii  ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps >  ${REPORT_DIR}/${MAIN_NAME_REPORT}.txt
	rm ${REPORT_DIR}/${MAIN_NAME_REPORT}.ps

#help	pdf_figures		generates the figures
.PHONY:	pdf_figures
pdf_figures:
	./generate_figures.sh

# --------------------------------------------------------

#help	view_report		view the PDF-file of the report
.PHONY: view_report
view_report: pdf_report
	${PDFVIEWER} ${REPORT_DIR}/${MAIN_NAME_REPORT}.pdf

# --------------------------------------------------------


#help	clean			clean up temporary files
.PHONY: clean
clean:
	find . -type f -name '*.aux' -delete
	find . -type f -name '*.log' -delete
	find . -type f -name '*.nav' -delete
	find . -type f -name '*.toc' -delete
	find . -type f -name '*.bbl' -delete
	find . -type f -name '*.out' -delete
	find . -type f -name '*.snm' -delete
	find . -type f -name '*.bcf' -delete
	find . -type f -name '*.lof' -delete
	find . -type f -name '*.tdo' -delete


#help	purge			cleaner than clean ;-)
.PHONY: purge
purge: clean
	find . -type f -name '20*.pdf' -delete
	find . -type f -name '*.ps' -delete
