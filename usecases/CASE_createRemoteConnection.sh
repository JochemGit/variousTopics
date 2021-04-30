#!/bin/bash

# provided by jenkins pipeline for normal cases
# minionVM1 minionVM2 qmVM1 qmVM2
pwd
cd $(dirname $0)
pwd

scriptname=$(basename $0)
echo "#######################"
echo "$scriptname: minionVM1=$minionVM1 minionVM2=$minionVM2 qmVM1=$qmVM1 qmVM2=$qmVM2"
echo "#######################"
exit 0
