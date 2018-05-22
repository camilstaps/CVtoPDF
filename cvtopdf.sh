#!/bin/bash

# usage: cvtopdf.sh [OPTS] NAME 

NAME="${@: -1}"
OPTS=${@:1:$(($#-1))}

"$(dirname "$0")"/combinecv.sh "$NAME"
latexmk $OPTS "$NAME.tex"
