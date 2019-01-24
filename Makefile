.SUFFIXES: .tex .fig .eps .pdf ;

all: latex.pdf

latex.pdf: tryLatex.tex
	./lpp -i tryLatex.tex -o latex.tex
	pdflatex latex.tex
	rm -f latex.tex

clean:
	rm -f latex.*
	rm -f *.pdf *.out
