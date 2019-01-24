.SUFFIXES: .tex .fig .eps .pdf ;

all: latex.pdf

latex.tex: tryLatex.tex
	./lpp < tryLatex.tex > latex.tex

latex.pdf: latex.tex
	pdflatex latex.tex

clean:
	rm -f latex.*
	rm -f *.pdf *.out
