

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

#Fonction qui permet de sélectionner le numéro des questions a donner à l'utilisateur de manière aléatoire
#Précondition : Le module doit être renseigné en variable env "MODULE"
#Necessite 0 ou 1 argument
#L'argument 1 permet de spécifier le nombre de questions souhaité
#S'il n'est pas spécifié, le nombre de questions par défaut est fixé a 10

findQuestionRandom() {

	#Permet de fixé le nombre de question souhaité
	if [ "$1" == "" ] ; then
	        nbQS=10
	else
	        nbQS=$1
	fi


	i=0


	#Si le module n'est pas spécifié ==> erreur
	if test -z $MODULE; then
	        echo $PROGNAME": Module non défini" >&2
	        exit 1
	fi

	if test -z $HOME; then
	        echo $PROGNAME": Home non défini" >&2
	        exit 1
	fi

	#Calcule le nombre de questions présentent dans le dossier questions
	nbDoss=`cd $HOME/Code/Modules/systemiutaubiere/questions; ls -l | grep .txt  | wc -l`


	#Boucle permettant l'ajout dans la liste
	while [ $(($i-1)) -lt $nbQS ]
	do
	        #Tire un numéro de questio au hasard
	        value=$((RANDOM % $nbDoss + 1))
	        listeQ+=" "
	        for question in $listeQ; do
			#Si le numéro est déjà dans la liste
	                if [ $question = $value ]; then
	                        i=$(($i-1))
	                        change="o"
	                fi
	        done
		local visibility=$(getQuestionElement $DB_MODULES_DIR/$MODULE/questions/$value.txt visibility)
	        if [ "$visibility" != "training" ]; then
			change="o"
		fi
		#Si la valeur est correcte on l'ajoute dans la liste
	        if [[ "$change" == "n" ]] ; then
	                listeQ+=$value
	        fi
 	       i=$(($i + 1))
	
        	change="n"
	done

	echo $listeQ
}
