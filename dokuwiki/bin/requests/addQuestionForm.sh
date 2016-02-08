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

<form action="$DOKU_CGI" method="POST">
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
<select name="type" id="question_type">
        <option value="mcq">QCM</option>
        <option value="commandname">Nom de commande</option>
        <option value="simplecommand">Commande simple</option>
        <option value="compoundcommand">Commande composée</option>
        <option value="freequestion">Question libre</option>
        <option value="script">Script</option>
</select><br><br>

<div id="mcq">
        <h3>QCM</h3>

        Reponses possibles:<br>
        <input type="text" name="mcq_availableAnswer1"> <input type="checkbox" name="mcq_availableAnswerTrue1"><br>
        <input type="text" name="mcq_availableAnswer2"> <input type="checkbox" name="mcq_availableAnswerTrue2"><br>
        <input type="text" name="mcq_availableAnswer3"> <input type="checkbox" name="mcq_availableAnswerTrue3"><br>
        <input type="text" name="mcq_availableAnswer4"> <input type="checkbox" name="mcq_availableAnswerTrue4"><br>
        <input type="text" name="mcq_availableAnswer5"> <input type="checkbox" name="mcq_availableAnswerTrue5"><br><br>
</div>

<div id="commandname">
        <h3>Nom de commande</h3>

        Reponse:<br>
        <input type="text" name="commandname_answer"><br><br>
</div>

<div id="simplecommand">
        <h3>Commande simple</h3>

        Reponse:<br>

        <input type="text" name="simplecommand_answer"><br><br>
</div>

<div id="compoundcommand">
        <h3>Commande composée</h3>

        Evaluateur:<br>

        <textarea name="compoundcommand_evaluator">
        #!/bin/bash
        </textarea>
</div>

<div id="freequestion">
        <h3>Question libre</h3>

        Evaluateur:<br>

        <textarea name="freequestion_evaluator">
        #!/bin/bash
        </textarea>
</div>

<div id="script">
        <h3>Script</h3>

        Evaluateur:<br>

        <textarea name="script_evaluator">
        #!/bin/bash
        </textarea>
</div>

<input type="submit" value="Ajouter la question"><br><br>
</form>

<script type="text/javascript">/*<![CDATA[*/
jQuery.ready(function() {
	jQuery("#question_type").change(function() {
		console.log("Type de question modifié.");
	});
});
/*!]]>*/</script>
</html>
EOF
        redirect users:$DokuUser:$dokuName
}

