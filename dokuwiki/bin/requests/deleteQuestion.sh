#/bin/bash

runRequest() {
	local dokuName=delete_question
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	
	local id=$(param id)

	# Est ce que l'utilisateur est professeur ?
	userIsProf
    
    if test $? -ne 0; then
    	dokuError "Vous n'êtes pas professeur"
    	exit 1
    fi

	# Validation de l'identifiant
	if test -z $id; then
		dokuError "Aucun ID fourni."
		exit 1
	fi

	local questionFile="$DB_MODULES_DIR/$module/questions/$id.txt"

	# La question existe-t-elle ?
	if test ! -f $questionFile; then
		dokuError "ID incorrect."
		exit 1
	fi

	rm $questionFile

	# La suppression est elle reussie ?
	if test $? -ne 0; then
		dokuError "Erreur rencontrée lors de la suppression de la question."
		exit 1
	fi

	cat << EOF > $out
==== Question supprimée ====

La question #$id a été supprimée.

[[$DOKU_CGI?module=$module&action=manageQuestions|Retourner à la gestion des questions]]

EOF
	redirect users:$DokuUser:$dokuName

	#local name=$(param name)
	#local list=$(param list)

	#name=$DokuUser-$name
	
	#local notFoundQuestions=""
	#for i in $list; do
	#	if [ ! -e $DB_MODULES_DIR/$module/questions/$i.txt ]; then
	#		notFoundQuestions="$notFoundQuestions $i"
	#	fi
	#	i =$(getQuestionElement $DB_MODULES_DIR/$module/questions/$i.txt id)
	#	nbquest=`cd $DB_MODULES_DIR/$module/questions; ls -l | grep .txt  | wc -l`
	#	mv $DB_MODULES_DIR/$module/questions/$nbquest.txt $DB_MODULES_DIR/$module/questions/$i.txt
	#done

	#if [ -n "$notFoundQuestions" ]; then
	#	dokuError "Les questions suivantes n'existent pas : $notFoundQuestions !"
	#	return 1
	#fi

	
	
	#redirect users:$DokuUser:modules
}
