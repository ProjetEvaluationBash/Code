#!/bin/bash

runRequest() {
	local out=$DOKU_USERS_DIR/$DokuUser/main_module.txt
        local module=$(param module)

        cat << EOF > $out
====== Module ($module) ======

=== Commandes utilisateur ===

  * [[$DOKU_CGI?module=$module&action=manageTrainingTest|Faire un entraînement]]
  * [[$DOKU_CGI?module=$module&action=doExamForm|Faire un examen]]
EOF

if userIsProf; then
        cat << EOF >> $out

=== Commandes professeur ===

  * [[$DOKU_CGI?module=$module&action=manageExamTest|Gestion des examens]]
  * [[$DOKU_CGI?module=$module&action=manageQuestions|Gestion des questions]]
  * [[$DOKU_CGI?module=$module&action=consultMark|Consulter les notes]]

=== Fonctions de deboggage ===

  * [[$DOKU_CGI?module=$module&action=debugListQuestions|Lister toutes les questions du module]]
  * [[$DOKU_CGI?module=$module&action=executeScript|Executer un script]]
  * [[$DOKU_CGI?module=$module&action=findQuestionByKeywordsForm|Trouver une question par mot clé]]

EOF

fi

        redirect users:$DokuUser:main_module
}
