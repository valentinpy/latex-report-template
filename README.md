Name: Latex-template
Licence: CC-by-sa
Author: Valentin Py
Last revision: September 2017

If you want to send corrections / improvements / ask questions ... => valentin.py@gmail.com

required:
bash
make
pdflatex
bibDesk
vim (because you don't need any other IDE :) )
LaTex distribution (e.g: MaxTex) with following packages:
-lslistings
-...


To use this tmeplate, simply clone this repo, install a LaTex distribution and start writing your report.

You can compile your document by using the provided makefile.
The command "make pdf_report" compiles your document and it'll be stored as "report/main.pdf".
Depending on your installation, you'll probably have to modify the Makefile to indicate the pdflatex location. This is done in "Makefile" at line 13/14. Normally, you can simply . use "PDFLATEX_CMD = pdflatex".

Your should put your chapters (where you write your text) in the "chapter" folder and include them in the "main.tex" file.

Elements on the title page are mostly located in "template/defines.tex" file.
