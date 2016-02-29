#!/bin/bash

function dokuwikiAddQuestion() {
	local evaluator=$(param compoundcommand_evaluator)
	
	return 0
}

# addQuestion()
function cliAddQuestion {
        return 0
}

function loadQuestion() {
	EVALUATOR=`getElement "$questionFileContents" evaluator`
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

function toString() {
    cat << EOF
<strong>EVALUATOR: </strong><br>
<code>
$EVALUATOR
</code>
EOF
}
