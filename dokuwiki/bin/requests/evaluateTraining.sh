#!/bin/bash

source "$CODE_DIR/Question.sh"
evaluateAnswer() {
	if test $# -ne 3; then
                echo "Usage: MCQ : EvalAnswer ANSWER" >&2
                return 0
        fi

	QUESTIONPATH=$1
	QUESTIONID=$2
	mainLoadQuestion
	isCorrect = dokuwikiEvaluateAnswer $3 
	if test $isCorrect -eq 0 ; then
		 return 1
	fi
	return 0

}

runRequest(){
	local dokuName=evaluate_training
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local temp=$(param tempNameTest)
	local list=`cat $temp`
	local testid=$(param testid)
	local testsDir=$DB_USERS_DIR/$DokuUser/$module/tests/$testid
	local answerDir=$testsDir/answers
	local questiondir=$testsDir/questions
	local score=0
	
	test_to_print=" "

	for i in $list; do
		local answerNum=`echo $i | cut -d: -f1`
		local questionNum=`echo $i | cut -d: -f2`
		local answerName="answer$answerNum"
		answer=$(param $answerName)
		echo $answer >> $answerDir/$questionNum.txt
		test_to_print+=$answer
		test_to_print+=" "
		pts=`evaluateAnswer $questiondir  $questionNum  $answer`		
		$score = $(($score + $pts))
		
	done

cat << EOF > $out
	==== $temp ====
	$test_to_print
	$answerDir
	$score
EOF
	#run "$DOKU_CGI?module=$module&action=displayTrainingAnswer"	
	redirect users:$DokuUser:$dokuName
}
