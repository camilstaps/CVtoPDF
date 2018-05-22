#!/bin/bash

# usage: combinecv.sh NAME

NAME="$1"
SEC=""
STYLE=""

INC=layouts

cp "$INC/pre.tex" "$NAME.tex"

cat "$NAME.cv" | while read LINE; do
	echo "$LINE"
	if [[ "${LINE:0:1}" == "#" ]]; then
		if [[ -e "$INC/${STYLE}post.tex" ]] && [[ "$STYLE" != "" ]]; then
			cat "$INC/${STYLE}post.tex" >> "$NAME.tex"
		fi
		SEC="${LINE:2}"
		echo -e "\n\n\\section{$(head -n1 "$SEC/$SEC")}\n\\label{sec:$SEC}\n" >> "$NAME.tex"
		STYLE="$(tail -n1 "$SEC/$SEC")"
		if [ -e "$INC/${STYLE}pre.tex" ]; then
			cat "$INC/${STYLE}pre.tex" >> "$NAME.tex"
		fi
	else if [[ "$LINE" == "~" ]]; then
		if [[ -e "$INC/${STYLE}post.tex" ]] && [[ "$STYLE" != "" ]]; then
			cat "$INC/${STYLE}post.tex" >> "$NAME.tex"
		fi
	else if [[ "$LINE" != "" ]]; then
		case "$STYLE" in
			table|densetable)
				head -n1 "$SEC/$LINE.tex" >> "$NAME.tex"
				echo -e "\t&" >> "$NAME.tex"
				tail -n +2 "$SEC/$LINE.tex" >> "$NAME.tex"
				echo "\\\\" >> "$NAME.tex"
				;;
			list)
				echo "\\item" >> "$NAME.tex"
				cat "$SEC/$LINE.tex" >> "$NAME.tex"
				;;
			*)
				cat "$SEC/$LINE.tex" >> "$NAME.tex"
		esac
	fi; fi; fi
done

cat "$INC/post.tex" >> "$NAME.tex"
