#!/bin/bash

cd $(dirname $0)
. ../jenkinsShellLib/pipelining.sh

restorePipelineVars
scriptname=$(basename $0)
wert2=$(uuidgen -t)
echo "$scriptname: Create QM2"
echo "$scriptname: $wert1"
echo "$scriptname: $wert2"
providePipelineVar "wert2=$wert2"
exit 0
