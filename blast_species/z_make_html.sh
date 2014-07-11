# z_make_html.sh
# 2014-04-07 dmontaner@cipf.es
# Run Pandoc for html


### PARAMETERS

myfile="blast_practical_species"

 css="../000_commons/estilo.css"
refs="../000_commons/refs.md"


### CSS parsing ################################################################

sty="estilo.sty"
echo  "<style>"   > $sty
cat   $css       >> $sty
echo ""          >> $sty
echo "</style>"  >> $sty


### Clean Flies ################################################################

rm $myfile.html
rm $myfile.pdf


### HTML #######################################################################


#pandoc -S       -c $css -f markdown -t html -o $myfile.html $myfile.md
#pandoc -S       -H $sty -f markdown -t html -o $myfile.html $myfile.md
 pandoc -S --toc -H $sty -f markdown -t html -o $myfile.html $myfile.md


### PDF ########################################################################

pandoc -f markdown -t latex -o $myfile.pdf $myfile.md


### BASH #######################################################################

# grep     "^    "    $myfile.md > $myfile.sh
# sed -i 's/^    //g'              $myfile.sh
# chmod +x                         $myfile.sh


### CLEAN UP ###################################################################
rm $sty
