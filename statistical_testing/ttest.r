##ttest.r
##2014-07-21 dmontaner@cipf.es
##Statistical testing with R: Student's t-test
## <http://en.wikipedia.org/wiki/T_test>
## <http://es.wikipedia.org/wiki/Prueba_t_de_Student>

## CLEAN THE WORKING ENVIRONMENT
rm (list = ls ())
options (width = 200)

## SIMULATE NORMAL DATA
N <- 1000
media <- 0
desviacion <- 1

N
media
desviacion

rnorm (n = N, mean = media, sd = desviacion)

## KEEP THE DATA
datos0 <- rnorm (n = N, mean = media, sd = desviacion)

## DISTRIBUTION
hist (datos0)

## DENSITY
hist (datos0, freq = FALSE)
lines (density (datos0))

plot (density (datos0))


## LOOP OVER THE MEAN VALUES
plot (density (datos0), xlim = c (-4,15), lwd = 3)
for (i in 1:10) {
    print (i)
    datos <- rnorm (n = N, mean = i, sd = desviacion)    
    lines (density (datos), col = i)
    readline ("press intro: ")
}


## LOOP OVER THE DEVIATION VALUES
plot (density (datos0), xlim = c (-4,7), ylim = c(0, 10), lwd = 3)
for (j in 1:10) {
    d <- 1/j
    print (d)
    datos <- rnorm (n = N, mean = 2, sd = d)    
    lines (density (datos), col = j+1)
    readline ("press intro: ")
}

################################################################################

## P-VALUE
t.test (x = datos, y = datos0)
t.test (x = datos, y = datos0)$p.value

## P-VALUE changes with the mean values
for (i in 1:10) {
    i <- i/50
    cat ("mean", i, fill = TRUE)
    datos <- rnorm (n = N, mean = i, sd = desviacion)    
    ##
    p <- t.test (x = datos, y = datos0)$p.value
    cat ("p-value: ", p, fill = TRUE)
    cat ("\n")
}


## P-VALUE changes with the standard deviation
for (j in 1:10) {
    d <- 1/j
    cat ("sd", d, fill = TRUE)
    datos <- rnorm (n = N, mean = 1, sd = d)
    ##
    p <- t.test (x = datos, y = datos0)$p.value
    cat ("p-value: ", p, fill = TRUE)
    cat ("\n")
}

