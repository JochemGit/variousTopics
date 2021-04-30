#!/bin/bash

# provided by jenkins pipeline for normal cases
# minionVM1 minionVM2 qmVM1 qmVM2
pwd
cd $(dirname $0)
pwd

queue=LQ
scriptname=$(basename $0)
echo "#######################"
echo "$scriptname: minion=$minionVM1 qm=$qmVM1 queue=$queue"
echo "#######################"
exit 0
