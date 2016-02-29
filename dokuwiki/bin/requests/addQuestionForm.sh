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
<table>
<tbody>
<tr>
<td>Question:</td>
<td><input type="text" name="question" value=""></td>
</tr>

<tr>
<td>Durée (en secondes):</td>
<td><input type="number" name="duration"></td>
</tr>

<tr>
<td>Difficulté:</td>
<td>
<select name="difficulty">
        <option value="1">Novice</option>
        <option value="2">Intermediaire</option>
        <option value="3">Expert</option>
</select>
</td>
</tr>

<tr>
<td>Visibilité de la question:</td>
<td>
<select name="visibility">
        <option value="hidden">Caché</option>
        <option value="training">Entrainement</option>
        <option value="exam">Examen</option>
</select>
</td>
</tr>

<tr>
<td>Type:</td>
<td>
<select name="type" id="question_type">
        <option disabled selected></option>
        <option value="MCQ">QCM</option>
        <option value="CommandName">Nom de commande</option>
        <option value="SimpleCommand">Commande simple</option>
        <option value="CompoundCommand">Commande composée</option>
        <option value="FreeQuestion">Question libre</option>
        <option value="Script">Script</option>
</select>
</td>
</tr>

<tr id="MCQ" class="question_type">
<td>Reponses possibles:</td>
<td>
<div id="mcq_availableAnswers">
<input type="text" name="mcq_availableAnswer1"> <input type="radio" name="mcq_answer" value="1"><br>
<input type="text" name="mcq_availableAnswer2"> <input type="radio" name="mcq_answer" value="2"><br>
</div>
<br><button type="button" id="mcq_addAvailableAnswer">+ Ajouter</button>
</tr>

<tr id="CommandName" class="question_type">
<td>Reponse:</td>
<td><input type="text" name="commandname_answer"></td>
</tr>

<tr id="SimpleCommand" class="question_type">
<td>Reponse:</td>
<td><input type="text" name="simplecommand_answer"></td>
</tr>

<tr id="CompoundCommand" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="compoundcommand_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>

<tr id="FreeQuestion" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="freequestion_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>

<tr id="Script" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="script_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>

</tbody>
</table>

<br><br>
<input type="submit" value="Ajouter la question"><br><br>
</form>

<script type="text/javascript">/*<![CDATA[*/
jQuery(document).ready(function() {
	jQuery(".question_type").hide();
	var nbAvailableAnswers = 2;

	jQuery("#question_type").change(function() {
		jQuery(".question_type").hide();
		
		qType = jQuery("#question_type").val();
		jQuery("#" + qType).show();
	});

	jQuery("#mcq_addAvailableAnswer").click(function() {
		nbAvailableAnswers++;

		if(nbAvailableAnswers == 10) {
			jQuery("#mcq_addAvailableAnswer").hide();
		}

		jQuery("#mcq_availableAnswers").append('<input type="text" name="mcq_availableAnswer' + nbAvailableAnswers + '"> <input type="radio" name="mcq_answer" value="' +  nbAvailableAnswers + '"><br>');
	});
});
/*!]]>*/</script>
</html>
EOF
        redirect users:$DokuUser:$dokuName
}

