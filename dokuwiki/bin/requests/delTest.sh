#!/bin/bash

runRequest() {
        local dokuName=del_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
        local test=$(param test)

        local testsDir=$DB_USERS_DIR/$DokuUser/$module/tests

        if userIsProf; then
                dokuError "Désolé, fonction réservée aux enseignants !"
        fi

        if [ ! -e $testsDir/$test ]; then
                dokuError "Le test $test n'existe pas !"
                return 1
        fi

        rm -Rf $testsDir/$test

        run "$DOKU_CGI?module=$module&action=manageTrainingTest"
}

