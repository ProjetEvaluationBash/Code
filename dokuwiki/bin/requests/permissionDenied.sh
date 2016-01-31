#!/bin/bash

runRequest() {
        cat << EOF > $DOKU_USERS_DIR/$DokuUser/permissiondenied.txt
===== Permission denied =====

  * Debug : user  : $DokuUser (from $HTTP_REFERER)
  * Debug : query : $QUERY_STRING



[[$DOKU_URL|Main]]
EOF

log "Permission denied : user  : $DokuUser (from $HTTP_REFERER)"
log "Permission denied : query : $QUERY_STRING"

cgiHeader
redirect users:$DokuUser:permissiondenied
}

