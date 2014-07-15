##microarray_analysis.r
##2014-07-15 dmontaner@cipf.es
##Celegans microarray data analysis
##We explore data from the series GSE38196 of the GEO database (fyestp://ftp.ncbi.nlm.nih.gov/geo)

## CLEAN THE WORKING ENVIRONMENT
rm (list = ls ())
options (width = 200)


## READ DATA
setwd ("datos")
dir  ()

ls ()

datos <- read.table (file = "GSE38196_series_matrix.txt", header = TRUE, comment.char = "!", as.is = TRUE)
ls ()
class (datos)
dim (datos)
datos[1:3,]

rownames (datos) <- datos[,1]
datos <- datos[,-1]
datos[1:3,]

## ARRAY CLASS
clases <- read.table (file = "GSE38196_series_matrix.txt", skip = 38, nrows = 1, as.is = TRUE)
clases
clases <- unlist (clases)
clases
clases <- clases[-1]
clases

length (clases)

table (clases)

WT <- clases == "genotype: wild-type"
WT

names (WT) <- colnames (datos)
WT

datos[1:3,]

################################################################################

## DATA EXPLORATION 
summary (datos)

boxplot (datos)
boxplot (datos, las = 3)
boxplot (datos, las = 3, log = "y")

color <- rep ("red", times = 12)
color
color[WT]
color[WT] <- "blue"
color

cbind (WT, color)

boxplot (datos, las = 3, log = "y", col = color)

hist (datos[,1])
hist (log (datos[,1]))

################################################################################

## DATA ANALYSIS: differential expression

WT
!WT

med.WT <- rowMeans (datos[,WT])
med.MU <- rowMeans (datos[,!WT])

class (med.WT)

med.WT[1:3]
med.MU[1:3]

table (names (med.WT) == rownames (datos))

plot (med.WT, med.MU)

fold.change <- med.MU / med.WT
fold.change[1:3]

summary (fold.change)

boxplot (fold.change)
abline (h = 0, col = "blue")

log.fold.change <- log (fold.change)
log.fold.change[1:3]

summary (log.fold.change)

boxplot (log.fold.change)
abline (h = 0, col = "blue")


### DIFFERENTIALLY EXPRESSED GENES
boxplot (log.fold.change)
abline (h = 0, col = "blue")
abline (h = c(-2, 2), col = "red")

es.up   <- log.fold.change >  2
es.down <- log.fold.change < -2

es.up[1:3]

table (es.up, es.down)

rownames (datos)[es.up]
rownames (datos)[es.down]

datos[es.up,]
datos[es.down,]


boxplot (datos, las = 3, col = color, log = "y")

rownames (datos)[es.up]
rownames (datos)[es.up][1]

id <- rownames (datos)[es.up][1]
id

log (datos[id,])

lines (1:12, log (datos[id,]))

id <- rownames (datos)[es.down][1]
id

lines (1:12, log (datos[id,]), col = "blue")



### LOOP

ids.up <- rownames (datos)[es.up]
ids.down <- rownames (datos)[es.down]

ids.up
ids.down

for (id in ids.up) {
    print (toupper (id))
}


 
boxplot (datos, las = 3, col = color, log = "y")

for (id in ids.up) {
    lines (1:12, log (datos[id,]), col = "red")
}

for (id in ids.down) {
    lines (1:12, log (datos[id,]), col = "blue")
}
