# CV combiner

This is a collection shell scripts that helps with managing a CV.

Sections of the CV are kept in directories; items in sections in files in these
directories. `combinecv.sh` combines all these files according to a
configuration file into one TeX file. `cvtopdf.sh` also compiles that file
using `pdflatex`.

In every section directory, there should be a file with the same name, with on
the first line the title and on the second line the style (`table`, `list` or
user-defined).

## Usage

```shellsession
$ cvtopdf.sh mycv
```

where the directory may look like:

```text
mycv.cv
contact
	contact
	name.tex
	email.tex
education
	education
	bachelor.tex
layouts
	pre.tex
	post.tex
```

and `mycv.cv` like this:

```text
# contact
name
email

# education
bachelor
```

## Configuration file
Configuration files are plain text. Every line can be one of the following:

- New section. The line should start with a `#`. The name is read from the
  third character onwards.
- Section entry. The line should contain the filename within the section.
- Empty line. These lines are ignored.
- A line containing only a tilde (`~`) closes the configuration file.

## Layouts
The file `layouts/pre.tex` is prepended to the output file.
The file `layouts/post.tex` is appended to the output file.

## Section styles
For all styles (pre-defined and user-defined), `layouts/STYLEpre.tex` is put
after the `\section*` line and `layouts/STYLEpost.tex` after the last entry (if
these files exist).

### `table`
Files in a section with the style `table` should have the left column on the
first line. The rest of the file is put in the right column. Only two columns
are supported.

### `list`
For the `list` style, `\item` is prepended to the text in the file.

### User-defined
The text from the file is copied directly into the output file.
