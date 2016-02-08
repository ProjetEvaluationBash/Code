#!/bin/bash

runRequest() {
	local out=$DOKU_USERS_DIR/$DokuUser/main_module.txt
        local module=$(param module)

        cat << EOF > $out
====== Module ($module) ======
  * [[$DOKU_CGI?module=$module&action=manageTrainingTest| Faire un entraînement]]
  * Faire un examen
EOF

if userIsProf; then
        cat << EOF >> $out

Opérations réservées :

  * [[$DOKU_CGI?module=$module&action=addQuestionForm|Ajouter une question]]
  * [[$DOKU_CGI?module=$module&action=consultMark|Consulter les notes]]
  * Créer un examen

Tests :

  * [[$DOKU_CGI?module=$module&action=questionsList|Lister les questions]]
  * [[$DOKU_CGI?module=$module&action=executeCommand|Executer une commande]]
  * [[$DOKU_CGI?module=$module&action=executeScript|Executer un script]]
  * [[$DOKU_CGI?module=$module&action=deleteQuestionForm|Supprimer une question]]
  * [[$DOKU_CGI?module=$module&action=manageExamTest|Gérer les examens]]
  * [[$DOKU_CGI?module=$module&action=findQuestionByKeywords|Trouver une questio par mot clé]]
EOF

fi

        cgiHeader
        redirect users:$DokuUser:main_module
}
