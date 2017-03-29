#!/bin/bash

# usage: cvtopdf.sh [OPTS] NAME 

NAME="${@: -1}"
OPTS=${@:1:$(($#-1))}
TEX="${TEX:-pdflatex} $OPTS"

"$(dirname "$0")"/combinecv.sh "$NAME"
$TEX "$NAME.tex" && $TEX "$NAME.tex"
