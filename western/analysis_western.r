##analysis_western.r
##2014-07-21 dmontaner@cipf.es
##Statistical analysis of Western blot data


## CLEAN THE WORKING ENVIRONMENT
rm (list = ls ())
options (width = 200)


## READ DATA
setwd ("datos")
dir  ()
dir (pattern = ".csv")

ficheros <- dir (pattern = ".csv")
ficheros

## this is an example of a loop
for (fi in ficheros) {
    print (fi)
    FI <- toupper (fi)
    print (FI)
}

ficheros
fi
FI

## we use a loop to congratulate to our ...fiend 100 times
variable.puntos <- ""
for (i in 1:100) {
    variable.puntos <- paste (variable.puntos, ".", sep = "")
    print (paste ("FELICIDADES", variable.puntos))
}


## now that we know what a loop is we use it to read our data into a list
datos <- list ()
datos
for (fi in ficheros) {
    print (fi)
    datos[[fi]] <- read.csv (fi)
}
datos


## revise formats
class (datos)
names (datos)
length (datos)

datos[[1]]
datos[["cuantificaciones_modificadas_bax.csv"]]
class (datos[[1]])
dim (datos[[1]])

for (fi in names (datos)) {
    print (fi)
    dat <- datos[[fi]]
    print (class (dat))
}

################################################################################

## EXPLORE DATA

## boxplot of one gene
boxplot (dat[,"RATIO"] ~ dat[,"CLASE"])

## boxplot for all genes
par (mfrow = c(1, 3)) #this line indicates that 3 graphs are going to be plot
for (fi in names (datos)) {
    print (fi)
    dat <- datos[[fi]]
    boxplot (dat[,"RATIO"] ~ dat[,"CLASE"])    
}

## include title
par (mfrow = c(1, 3)) #this line indicates that 3 graphs are going to be plot
for (fi in names (datos)) {
    print (fi)
    dat <- datos[[fi]]
    boxplot (dat[,"RATIO"] ~ dat[,"CLASE"], main = fi)    
}

## work in LOG scale
par (mfrow = c(1, 3)) #this line indicates that 3 graphs are going to be plot
for (fi in names (datos)) {
    print (fi)
    dat <- datos[[fi]]
    boxplot (log (dat[,"RATIO"]) ~ dat[,"CLASE"], main = fi)    
}


################################################################################

## HYPOTHESIS TESTING

t.test (log (dat[,"RATIO"]) ~ dat[,"CLASE"])

for (fi in names (datos)) {
    print (fi)
    dat <- datos[[fi]]
    print (t.test (log (dat[,"RATIO"]) ~ dat[,"CLASE"]))
}

