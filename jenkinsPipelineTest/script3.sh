#!/bin/bash

cd $(dirname $0)
. ../jenkinsShellLib/pipelining.sh

restorePipelineVars
scriptname=$(basename $0)
wert3=$(uuidgen -t)
echo "$scriptname: Create Remote Connection"
echo "$scriptname: $wert1"
echo "$scriptname: $wert2"
echo "$scriptname: $wert3"
exit 0
