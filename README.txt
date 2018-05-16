Reproducible Science Template, README
Daniel C. Reuman
----

This repository provides a template to aid in producing a truly reproducible, 
publishable scientific analysis using R markdown. It solves various problems 
like wanting to have separate main text and supporting information Rmd files
that nonetheless refer to each other, and using the checkpoint package to 
ensure reproducibility of results based on R packages on CRAN.

One way to use this is to fork the repository, rename it, and then start work. 
Of course you can also just read the files, learn tricks, and use them in your
own workflow.

Prerequisites: 
R and R markdown; some knowledge of latex and bibtex may help. 

Features of the setup:
1) All computations should be embedded in chunks in SuppMat.Rmd. Paper.Rmd
should just suck up results saved by SuppMat.Rmd, for display.
2) For citations, create entries in REF_ALL.bib following the formats there 
and then callouts in the .Rmd files with [@label] and @label, etc.
3) Cross-document references (made, e.g., in the main text to figures, tables, 
sections in the supp mat) are made with \ref{SM-<label>}. To cite things in the
main text from the supp mat, use \ref{MT-<label>}.
4) I recommend that scripts and functions be placed in the root directory of the 
repository, and source'd in chunks within SuppMat.Rmd. I recommend that all results 
(figures, tables, RDS files) be stored by the code in the "results" subdirectory. 
I recommend that all data be placed in the "data" directory. But there are also 
other ways of organizing things that work well.
5) Style follows Ecology Letters, but this can be changed in the YAML headers
if you have the cls file you want.

I have tried to demo most of these features in the document. Obviously you should
delete these demos from your own documents if you fork this repo.

How to run/compile: 
Due to the cross-document references, knitting within R studio will not work - 
it won't get the cross-document refences right (but should otherwise be OK, 
I think). Instead, knit makefile.Rmd. Knitting the makefile causes SuppMat.Rmd 
and MainText.Rmd to be knitted and also gets the cross-document references 
right, and produces a pdf called makefile.pdf with all the screen output of 
the knitting process.

This compilation process worked on my ubuntu 14.04 machine and on my Windows 
7 machine. You need to have pdflatex installed (Miktex for windows), and various 
R packages. I have not tested this on Mac. If you test it on Mac I would like to 
hear how it goes, email me at reuman@ku.edu, please.

Lots of intermediate files are procuced when you run the makefile. Some of these
can be useful for diagnosing problems. If you decide to delete them, they will
come back next time you run the makefile, so usually it is best to just ignore them.
And be careful, if you delete them, that you don't accidentally also delete one 
of the files you need! Don't commit the auto-generated files to version control. 

Other templates:
There are other templates out there with similar missions:
http://svmiller.com/blog/2016/02/svm-r-markdown-manuscript/
The rticles package on CRAN is well developed and serves some of the same goals

Acnowledgements:
David Orme, Imperial College London