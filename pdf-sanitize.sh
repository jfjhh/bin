#!/bin/bash

echo "Removing PDF watermarks and metadata, and linearizing all resultant PDF files..."
parallel -v --will-cite 'pdfparanoia {} | exiftool -o {.}_paranoid_clean.pdf -all= -' ::: *.pdf
parallel -v --will-cite 'qpdf --linearize {} {.}_linearized.pdf; rm {}' ::: *_paranoid_clean.pdf

