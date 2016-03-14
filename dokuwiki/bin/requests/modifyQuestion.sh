#/bin/bash

runRequest() {
	local dokuName=modify_question
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

	cat << EOF > $out
==== Modification de la question ====

Modification de la question $id

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
EOF

if test "$TYPE" = "MCQ"; then

cat << EOF >> $out
<tr id="MCQ" class="question_type">
<td>Reponses possibles:</td>
<td>
<div id="mcq_availableAnswers">
<input type="text" name="mcq_availableAnswer1"> <input type="radio" name="mcq_answer" value="1"><br>
<input type="text" name="mcq_availableAnswer2"> <input type="radio" name="mcq_answer" value="2"><br>
</div>
<br><button type="button" id="mcq_addAvailableAnswer">+ Ajouter</button>
</tr>
EOF
fi

if test "$TYPE" = "CommandName"; then


cat << EOF >> $out

<tr id="CommandName" class="question_type">
<td>Reponse:</td>
<td><input type="text" name="commandname_answer"></td>
</tr>
EOF
fi

if  test "$TYPE" = "SimpleCommand" ; then


cat << EOF >> $out


<tr id="SimpleCommand" class="question_type">
<td>Reponse:</td>
<td><input type="text" name="simplecommand_answer"></td>
</tr>
EOF
fi

if test "$TYPE" ="CompoundCommand" ; then

cat << EOF >> $out

<tr id="CompoundCommand" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="compoundcommand_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>
EOF
fi

if test "$TYPE" ="FreeQuestion" ; then

cat << EOF >> $out

<tr id="FreeQuestion" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="freequestion_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>

EOF
fi

if test "$TYPE" ="Script" ; then

cat << EOF >> $out

<tr id="Script" class="question_type">
<td>Evaluateur:</td>
<td>
<textarea name="script_evaluator">
#!/bin/bash
</textarea>
</td>
</tr>
EOF
fi

cat << EOF >> $out

<tr id="Keywords">
	<td>Mots clés:</td>
	<td>
		<div id="keywords">
			<input type="text" name="keyword1"><br>
			<input type="text" name="keyword2"><br>
		</div>
		<br><button type="button" id="addKeywordButton">+ Ajouter</button>
	</td>
</tr>
</tbody>
</table>
<br><br>
<input type="submit" value="Valider la modification de la question"><br><br>
</form>
<script type="text/javascript">/*<![CDATA[*/
jQuery(document).ready(function() {
	jQuery(".question_type").hide();
	var nbAvailableAnswers = 2;
	var nbKeywords = 2;

	jQuery("#question_type").change(function() {
		jQuery(".question_type").hide();
		
		qType = jQuery("#question_type").val();
		jQuery("#" + qType).show();
	});

	jQuery("#mcq_addAvailableAnswer").click(function() {
		nbAvailableAnswers++;

		if(nbAvailableAnswers >= 10) {
			jQuery("#mcq_addAvailableAnswer").hide();
			return;
		}

		jQuery("#mcq_availableAnswers").append('<input type="text" name="mcq_availableAnswer' + nbAvailableAnswers + '"> <input type="radio" name="mcq_answer" value="' +  nbAvailableAnswers + '"><br>');
	});
	
	jQuery("#addKeywordButton").click(function() {
		nbKeywords++;
		
		if(nbKeywords >= 10) {
			jQuery("#addKeywordButton").hide();
			return
		}
		
		jQuery("#keywords").append('<input type="text" name="keyword' + nbKeywords + '"><br>');
	});
});
/*!]]>*/</script>
</html>


[[$DOKU_CGI?module=$module&action=manageQuestions|Retourner à la gestion des questions]]

EOF
	redirect users:$DokuUser:$dokuName

}
