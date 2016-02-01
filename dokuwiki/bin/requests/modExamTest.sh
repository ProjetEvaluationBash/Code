#!/bin/bash

runRequest() {
	local dokuName=create_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local name=$(param name)
	local list=$(param list)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams

        if userIsProf; then
                dokuError "Désolé, fonction réservée aux enseignants !"
        fi

	#name="$DokuUser-$name"

	# l'espace est le séparateur des questions
	list=$(echo $list | tr '+' ' ')

	#if [ -e $examsDir/$name ]; then
	#	dokuError "L'examen $name existe déjà !"
	#	return 1
	#fi

	local notFoundQuestions=""
	for i in $list; do
		if [ ! -e $DB_MODULES_DIR/$module/questions/$i.txt ]; then
			notFoundQuestions="$notFoundQuestions $i"
		fi
	done

	if [ -n "$notFoundQuestions" ]; then
		dokuError "Les questions suivantes n'existent pas : $notFoundQuestions !"
		return 1
	fi

	local notExamQuestions=""
	for i in $list; do
		local visibility=$(getQuestionElement $DB_MODULES_DIR/$module/questions/$i.txt visibility)
                if [ "$visibility" != "exam" ]; then
                        notExamQuestions="$notExamQuestions $i"
                fi
        done

        if [ -n "$notExamQuestions" ]; then
                dokuError "Les questions suivantes ne sont pas des questions d'examen : $notExamQuestions !"
                return 1
        fi

	rm -Rf $examsDir/$name
	mkdir -p $examsDir/$name
	echo "$list" > $examsDir/$name/list
	mkdir $examsDir/$name/questions
	for i in $list; do
		cp $DB_MODULES_DIR/$module/questions/$i.txt $examsDir/$name/questions
        done

	cat << EOF > $out
====== Modification d'un examen (module $module) ======

  * dir=$examsDir/$name
  * Examen : $name
  * Liste  : $list

EOF

	run "$DOKU_CGI?module=$module&action=manageExamTest"
}
