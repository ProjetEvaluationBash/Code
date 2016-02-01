#!/bin/bash

runRequest() {
        cat << EOF > $DOKU_USERS_DIR/$DokuUser/debug.txt
===== Error =====

  * Debug : user  : $DokuUser (from $HTTP_REFERER)
  * Debug : query : $QUERY_STRING



[[$DOKU_URL|Main]]
EOF

log "Debug : user  : $DokuUser (from $HTTP_REFERER)"
log "Debug : query : $QUERY_STRING"

cgiHeader
redirect users:$DokuUser:debug
}

