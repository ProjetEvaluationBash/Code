#!/bin/sh


### FIXME

runRequest() {

        if ! userIsProf; then
                cgiHeader
                redirect users:$DokuUser:permissionDenied
                return 1
        fi

        local out=$DOKU_USERS_DIR/$DokuUser/questions.txt
        local list="1 2 3 4 5 6 7 8 9 10 11"
	local module=$(param module)

        cat << EOF > $out
====== Liste des questions du module $module ======
EOF

        for q in $list; do

                echo "  * [[https://fraise.u-clermont1.fr/info/cgi-bin/run.sh?module=$module&question=$q&maction=showQuestion|$q]]" >> $out
        done


        cgiHeader
        redirect users:$DokuUser:questions

}



