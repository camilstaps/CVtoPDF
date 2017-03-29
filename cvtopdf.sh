#!/bin/bash

# usage: cvtopdf.sh [OPTS] NAME 

"$(dirname "$0")"/combinecv.sh "${@: -1}"
pdflatex ${@:1:$(($#-1))} ${@: -1}.tex
pdflatex ${@:1:$(($#-1))} ${@: -1}.tex
