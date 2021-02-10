#!/bin/bash

. /home/juser/.nvm/nvm.sh
newman run ~juser/CleanEnvironment.postman_collection.json -e ~juser/Notebook\ Salt\ test\ environment.postman_environment.json -g ~juser/My\ Workspace.postman_globals.json --insecure
