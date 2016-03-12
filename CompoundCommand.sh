#!/bin/bash

source "$CODE_DIR/dokuwiki/bin/requests/script.sh"

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
<textarea name="answer$ID"></textarea><br>
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

function dokuwikiEvaluateAnswer() {
	if test $# -ne 1; then
                echo "Usage: MCQ : EvalAnswer ANSWER" >&2
                return 1
        fi

        local userAnswer=$1

			
	evaluateScript $userAnswer      	   
        
       

        # Reponse fausse
        return 1

}
