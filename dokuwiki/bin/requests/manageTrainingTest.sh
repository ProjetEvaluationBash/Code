#! /bin/bash

runRequest() {
	local dokuName=manange_training
	local out=$DOKU_USER_DIR/$dokuName.txt
	local module=$(param module)

	cat << EOF > $out

	* [[$DOKU_CGI?module=$module&action=createTest|Générer mon test]]


	EOF


}
