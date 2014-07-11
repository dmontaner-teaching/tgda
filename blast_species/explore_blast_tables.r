##' # Reading blast result tables with R
##' [David Montaner](http://www.dmontaner.com "my home page") _(2014-04-07)_  
##'
##' The script shows some commands to explore BLAST results in tabular format.
##' 
##' ----------------------------------------------------------------------------

#rm (list = ls ())

##' Set the working directory
#setwd ("data")
#dir ()

dir ("data")

##' ## Read the first table
datos1 <- read.table (file = "data/my_tab_blast.txt",  header = FALSE, sep = "\t", quote = "", as.is = TRUE)
dim (datos1)
datos1[1:3,]
sapply (datos1, class) ## classes of the variables 


##' We know the meaning of each of the columns form the documentation
colnames (datos1) <- c("queryID", "subjectIDs", "identity.percent", "alignment.length", "mismatches", "gap.opens", "q.start", "q.end", "s.start", "s.end", "evalue", "bit.score")
datos1[1:3,]


##' Find out the number of sequences which where blasted,
unicos <- unique (datos1[,"queryID"])
unicos[1:3]
length (unicos)

##' Some of our original reads or sequences may not have a blast hit,
##' lets find them.
##'
##' First we will read the original IDs extracted from the fasta file
ids <- readLines ("data/myids.txt")
ids[1:3]
length (ids)

##' As expected, all the IDs in the blast results are in the fasta file:
table (unicos %in% ids)

##' but some original ids are not in the blast output
setdiff (ids, unicos)

##' We can count how may hits does it have every sequence
counts <- table (datos1[,"queryID"])
counts[1:3]

suma <- sum (counts[1:3])
suma


##' Be careful as table rearranges its output.
datos1[1:suma, 1:2]

##' To make the proper selection
touse <- datos1[,"queryID"] %in% names (counts[1:3])
table (touse)
which (touse) ##these are the positions

datos1[touse, 1:2]





##' ## Read the second table
datos2 <- read.table (file = "data/my_tab_blast_and_species.txt",  header = FALSE, sep = "\t", quote = "", as.is = TRUE)
dim (datos2)
datos2[1:3,]
sapply (datos2, class) ## classes of the variables 

##' Set the row names 
colnames (datos2) <- c("qseqid", "sgi", "sacc", "saccver", "staxids")
datos2[1:3,]

##' Check that the two datasets are arranged in the same order
table (datos1$queryID == datos2$qseqid)

##' The rows of the two datasets are in the same order. We can then combine them in a unique data.frame:
datos <- cbind (datos1, datos2)
class (datos)
dim (datos)
sapply (datos, class)

##' We can clean up the working space form the data.frames datos1 and datos2.
rm (datos1, datos2)
ls ()

##' Doing this we avoid being confused with all data.frames.
##' but we also let some ram memory free.
##' To clear the memory cache we can use the command:
gc ()



##' ## Get the Best Hits
##' Observe that all e-values are under certain predefined threshold
summary (datos[, "evalue"])
##' in this case
0.0004


##' Then the __best hit__ is the one with the maximum __bit score__.
##' Generally the BLAST results are ordered, but we can test it:
for (uni in unicos) {
    touse <- datos$queryID == uni
    #print (max (datos[touse, "bit.score"]) == datos[touse, "bit.score"][1]) # the  first bit.score is the maximum
    if (max (datos[touse, "bit.score"]) != datos[touse, "bit.score"][1]) stop ("PROBLEM")  # the stop should not be executed
}


##' In the case that we needed to rearrange the rows we could do:
## orden <- order (datos$queryID, datos$bit.score, decreasing = TRUE) ## THIS LINE DEFINES THE ORDER
## orden[1:3]
## datos <- datos[orden,] ## THIS LINE REARRANGES THE ROWS OF THE data.frame


##' Now that we know that our data.frame is ordered,
##' we can simply select the first row for each of the sequence identifiers.
##' The function `duplicated` may help. 
dup <- duplicated (datos[,"queryID"])
table (dup)

##' So we keep the __not__ duplicated rows:
datos <- datos[!dup,]
dim (datos)


##' And now we can compute the counts of each of the species
sort (table (datos[,"staxids"]))

##' in percentages
100 * sort (table (datos[,"staxids"])) / nrow (datos)

##' So the most common species is `r names (sort (table (datos[,"staxids"]), decreasing = TRUE)[1])`
##'
##' ----------------------------------------------------------------------------
