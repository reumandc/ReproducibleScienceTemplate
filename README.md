# Reproducible Science Template

Daniel C. Reuman, University of Kansas  
David Orme, Imperial College London


This repository provides a template to aid in producing a truly reproducible, publishable scientific analysis using R Markdown. It solves various problems like wanting to have separate main text and supporting information Rmd files that nonetheless refer to each other, and using the `checkpoint` package to ensure reproducibility of results based on R packages on CRAN.

One way to use this is to fork the repository, rename it, and then start work. Of course you can also just read the files, learn tricks, and use them in your own workflow.

## Prerequisites:

R and R markdown; some knowledge of `latex` and `bibtex` may help. 

## Dependencies and related notes:


### The R `checkpoint` package

This template is set up to use the R `checkpoint` package. This is set up in the master file `makefile.Rmd` in the code chunk called `checkpoint_package`, which contains a line of code specifying a date.

    checkpoint("2018-03-29",checkpointLocation = "./")

The `checkpoint` package then automatically scans through the R markdown (`.Rmd`) and source (`.R`) files in the root directory looking for other required R packages. It then downloads and installs the newest versions of those packages available on the given date. This ensures that re-compiling the document uses _exactly_ the same code that was originally used. This can take some time on first run (you are warned) but it is faster on subsequent runs because the packages are already installed. Adding a new library() or require() statements means knitting will again be slow the first time after the addition.

This also means that R package dependencies should only be the `checkpoint` package, since that package should scan for other packages and install them locally. If you delete the `checkpoint_package` chunk in the makefile, of course, then there may be additional dependencies needed to recompile the documents.

### `pandoc`

The open source program `pandoc` converts documents from one format to another. Here, the `knitr` package uses it to convert the markdown files into `latex` format so that they can then be turned into PDF files. Installers for multiple operating systems are available here:

    https://pandoc.org/installing.html

Note that `pandoc` would also allow you to convert your R analysis to a range of other options (such as webpages) but the template only currently supports  PDF. 


### `pdflatex`

The makefile makes a system call to `pdflatex`, so software supporting that needs to be installed:

  * On Windows, you can use Miktex (https://miktex.org/howto/install-miktex), 
  * On Linux, install latex (e.g., sudo apt-get install texlive), and
  * On Mac, use the MacTeX installer (http://www.tug.org/mactex/)

## Features of the setup:

  1. All computations should be embedded in chunks in `SuppMat.Rmd`. `Paper.Rmd` should just suck up results saved by `SuppMat.Rmd`, for display.
  2. For citations, create entries in `REF_ALL.bib` following the formats there and then callouts in the `.Rmd` files with `[@label]` and `@label`, etc.
  3. Cross-document references (made, e.g., in the main text to figures, tables, in the supp mat) are made with `\ref{SM-<label>}`. To cite things in the main text from the supp mat, use `\ref{MT-<label>}`.
  4. We recommend that scripts and functions be placed in the root directory of the repository, and source'd in chunks within `SuppMat.Rmd`. We recommend that all results (figures, tables, RDS files) be stored by the code in the `results` subdirectory. We recommend that all data be placed in the `data` directory. But there are also other ways of organizing things that work well.
  5. Style follows Ecology Letters, but this can be changed in the YAML headers if you have the cls file you want.

We have tried to demo most of these features in the document. Obviously you should delete these demos from your own documents if you fork this repo and use it to create your own analysis and paper.

## How to run/compile: 

Due to the cross-document references, knitting `SuppMat.Rmd` or `MainText.Rmd` directly within R studio will not work - it won't get the cross-document refences right (but should otherwise be OK). Instead, knit `makefile.Rmd`. Knitting the makefile causes `SuppMat.Rmd` and `MainText.Rmd` to be knitted and also gets the cross-document references right, and produces a pdf called `makefile.pdf` with all the screen output of the knitting process.

To compile the documents from the command line, use the following:

    Rscript -e "library(knitr); knit('makefile.Rmd')" 

This compilation process was tested by Reuman on on ubuntu 14.04 and Windows 7 and by Orme on Max OS. Email us, please, with bugs or suggestions for improvement (reuman@ku.edu, d.orme@imperial.ac.uk).

## Intermediate files

Compiling the documents to PDF automatically produces a lot of 'intermediate' files. Files ending in `.tex` are the converted documents from `.Rmd` including all the R code output and the rest (files ending `.log`, `.aux`, `.lof`, `.lot`, `.toc`  and `.out` ) are intermediate files that `pdflatex` uses to keep track of various parts of the document. Some of these can be useful for diagnosing problems. If you decide to delete them, they will come back next time you knit the makefile, so usually it is best to just ignore them. And be careful, if you delete them, that you don't accidentally also delete one of the files you need! 

Don't commit the auto-generated files to version control.  We have added files ending with the file suffixes above to the `.gitignore` file for this template. This file contains a list of files and folders that `git` does not consider as updates to the repository - you should get  a warning if you do try and commit them.

## See also

There are other templates out there with similar missions:
- http://svmiller.com/blog/2016/02/svm-r-markdown-manuscript/
- The rticles package on CRAN is well developed and serves some of the same goals
