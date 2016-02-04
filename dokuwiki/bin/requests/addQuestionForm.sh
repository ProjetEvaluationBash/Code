#!/bin/bash

runRequest() {
	local dokuName=add_question_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
===== Ajouter une question =====

<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="addQuestion">
<p>
Question:
<input type="text" name="question" value=""><br>

Durée (en minutes):
<input type="number" name="duration"><br>

Difficulté:
<select name="difficulty">
        <option value="1">Novice</option>
        <option value="2">Intermediaire</option>
        <option value="3">Expert</option>
</select><br>

Visibilité de la question:
<select name="visibility">
        <option value="hidden">Caché</option>
        <option value="training">Entrainement</option>
        <option value="exam">Examen</option>
</select><br>

<p>
Type:
<select name="type">
        <option value="mcq">QCM</option>
        <option value="commandname">Nom de commande</option>
        <option value="compoundcommand">Command composée</option>
        <option value="freequestion">Question libre</option>
        <option value="script">Script</option>
</select><br><br>

<h3>QCM</h3>

Reponses possibles:<br>
1: <input type="text" name="availableAnswers[]"> <input type="checkbox" name="availableAnswersTrue[]"><br>
2: <input type="text" name="availableAnswers[]"> <input type="checkbox" name="availableAnswersTrue[]"><br> 
3: <input type="text" name="availableAnswers[]"> <input type="checkbox" name="availableAnswersTrue[]"><br>
4: <input type="text" name="availableAnswers[]"> <input type="checkbox" name="availableAnswersTrue[]"><br>
5: <input type="text" name="availableAnswers[]"> <input type="checkbox" name="availableAnswersTrue[]"><br><br>

<input type="submit" value="Créer"><br><br>
</form>
</html>
EOF
        redirect users:$DokuUser:$dokuName
}

