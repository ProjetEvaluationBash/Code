#!/bin/bash

function dokuwikiAddQuestion() {
	local evaluator=$(param script_evaluator)
	
	return 0
}

# addQuestion()
function cliAddQuestion {
        return 0
}

function loadQuestion() {
	return 0
}

function showQuestion() {
cat << EOF >> $out
<p>
Votre script : <br>
<textarea name="answer$j"></textarea><br>
</p>
EOF
	return 0
}
