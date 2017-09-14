#!/bin/bash

#let's process all *.tex files in the folder figures with pdflatex. Those files contain a latex-compilable figure.
#TODO: for improving compilation time, only recompile what is needed
for f in $(find ./figures -name '*.tex'); do

	printf "\nProcessing new file:\n"

	filename="${f##*/}"
	dir="${f%/*}"
	basename="${filename%.*}"

	echo $f;
	echo $filename;
	echo $dir
	echo $basename;

	pushd $dir
	pdflatex $filename
	popd
done
