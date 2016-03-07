#!/bin/bash


runRequest(){
	local dokuName=evaluate_training
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local temp=$(param tempNameTest)
	local list=`cat $temp`
	local testsDir=$DB_USERS_DIR/$DokuUser/$module/tests
	local answerDir=$testsDir/answers
	
	test_to_print=" "

	for i in $list; do
		local answerNum=`echo $i | cut -d: -f1`
		local questionNum=`echo $i | cut -d: -f2`
		local answerName="answer$answerNum"
		answer=$(param $answerName)
		echo $answer >> $anwerDir/$questionNum.txt
		test_to_print+=$answer
		test_to_print+=" "

	done

cat << EOF > $out
	==== $temp ====
	$test_to_print
	$answerDir
EOF
		
	redirect users:$DokuUser:$dokuName
}
