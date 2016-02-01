#! /bin/bash

runRequest() {
	local dokuName=manange_training
	local out=$DOKU_USERS_DIR/DokuUser/$dokuName.txt
	local module=$(param module)

	cat << EOF > $out

	* [[$DOKU_CGI?module=$module&action=createTest|Générer mon test]]


	EOF
	
	redirect users:$DokuUser:$dokuName

}
