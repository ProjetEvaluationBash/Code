

# Affiche un condensé d'une question
# $1 : numéro de la question

showQuestionItem() {
        local type=$(getQuestionElement $1 type)
        local visibility=$(getQuestionElement $1 visibility)
	local name=$(basename $1 .txt)
	local path=$(echo $1 | sed -re "s,^.*/users/$DokuUser/(.*).txt$,\1," | tr '/' ':')
        cat << EOF >> $out
  * [[$DOKU_URL?id=users:$DokuUser:$path|$name]] ($type/$visibility)

$(getQuestionElement $1 question)

EOF
}

# Extrait un élement d'une question
# $1 : le fichier question
# $2 : le nom de l'élément (difficulty, question, ...)

getQuestionElement() {

        cat $1 | gawk '
        BEGIN {
                firstPrinted=0
                show=0
        }

        /===[[:space:]]*'$2'[[:space:]]*===/ {
                show=1
                firstPrinted=0
                next
        }

        /=== / {
                firstPrinted=0
                show=0
                next
        }


        /^[[:space:]]*$/ {
                if(show && firstPrinted) {
                        blanks++
                        next
                }
        }

        {
                if (show==1) {
                        if(firstPrinted) {
                                for(i=0; i<blanks; i++) {
                                        print ""
                                }
                        }
                        print
                        firstPrinted=1
                }
        }'
}
