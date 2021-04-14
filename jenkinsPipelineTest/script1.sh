#!/bin/bash

pwd
. ../jenkinsShellLib/pipelining.sh

scriptname=$(basename $0)
wert1=$(uuidgen -t)
echo "#######################"
echo "JENKINS_HOME: ${JENKINS_HOME:-None}"
echo "#######################"
echo "$scriptname: Create QM1"
echo "$scriptname: $wert1"
providePipelineVar "wert1=$wert1"
exit 0
