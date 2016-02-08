#!/bin/bash

function dokuwikiAddQuestion() {
	local evaluator=$(param script_evaluator)

	return 0
}

# addQuestion()
function cliAddQuestion() {
	return 0
}

function loadQuestion() {
	return 0
}

function showQuestion() {

	echo "<html>"
	echo "<form name=\"userAnswer\"  method=\"POST\">"
	echo "<p>"
	echo "Votre script : <br>"
	echo "<textarea></textarea><br>"
	echo "</p>"
	echo "</form>"
	echo "</html>"
	
	return 0
}
