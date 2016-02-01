#!/bin/bash

PROGDIR=$(readlink -m $(dirname $0))
CODEROOT="$PROGDIR/.."

source "$CODEROOT/Question.sh"

QUESTIONPATH="$CODEROOT/Modules/systemiutaubiere/questions"
QUESTIONID=1

mainLoadQuestion

mainToString
