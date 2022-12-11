# Makefile
#
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

EXPORTED_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
 $(SOURCE_DOCS:.md=.docx) \
 $(SOURCE_DOCS:.md=.rtf) \
 $(SOURCE_DOCS:.md=.odt) \
 $(SOURCE_DOCS:.md=.epub)

RM=rm

PANDOC=pandoc

PANDOC_OPTIONS=--standalone --filter ./.pandoc/pandoc-crossref --citeproc --bibliography bibliography.bib -V papersize=a4paper -V geometry:margin=3cm -V lang=en-US -V fontsize=11pt -V breakurl -V hyphens=URL -V colorlinks -V mainfont:Lato --data-dir=./.pandoc

PANDOC_HTML_OPTIONS=--to html5 --toc --self-contained
PANDOC_PDF_OPTIONS=--pdf-engine=lualatex --template eisvogel --listings
PANDOC_DOCX_OPTIONS=--reference-doc=.pandoc/reference.docx
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=--reference-doc=.pandoc/reference.docx
PANDOC_EPUB_OPTIONS=--to epub3


# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o output/$@ $<

%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o output/$@ $<

%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o output/$@ $<

%.rtf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o output/$@ $<

%.odt : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o output/$@ $<

%.epub : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o output/$@ $<


# Targets and dependencies

.PHONY: all clean

all : $(EXPORTED_DOCS)

clean:
	- $(RM) $(EXPORTED_DOCS)
