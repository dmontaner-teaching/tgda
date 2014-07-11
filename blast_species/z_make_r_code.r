#! /usr/local/bin/Rscript --vanilla

##z_make_r_code.r
##2014-03-31 dmontaner@cipf.es
##Runs spin using knitr

## NOTE: the scripts are executed one after the other one.
##       The environment is not cleaned up.
##       The q() command at the end of the scripts ends the process.

## NOTE: spin does not stop with errors 

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.0.2 (2013-09-25)"
library (knitr); packageDescription ("knitr", fields = "Version") #"1.5"
##help (package = knitr)

opts_chunk$set (comment = ">")   ## symbol preceding the R output


### FILES TO COMPILE:
setwd ("/home/dmontaner/documentos/masterUV/mis_cursos/NOCIONES_BASICAS_2013_2014/clases/2014_07_practical_blast_especies")
dir ()

bases <- c ("explore_blast_tables") ## File names WITHOUT extension

for (base in bases) {
    print (base)
    rm (list = setdiff (ls (), c("base", "bases")))  
    unlink (paste0 (base, ".html"))
    spin   (paste0 (base, ".r"), doc = "^##+'[ ]?")  ## double has plus quote instead of single has plus quote is used to indicate md/text chunks (as in roxygen doc. using emacs)
    unlink (paste0 (base, ".md"))
    unlink (paste0 (base, ".Rmd"))
}

#unlink ("misdatos.txt")


###EXIT
warnings ()
sessionInfo ()
q ("no")
