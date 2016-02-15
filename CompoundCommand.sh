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
<html>
<form name="$j"  method="POST">
<p>
Votre script : <br>
<textarea></textarea><br>
</p>
</form>
</html>
EOF
	return 0
}
