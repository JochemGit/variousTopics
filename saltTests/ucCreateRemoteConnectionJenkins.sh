#!/bin/bash

. /home/juser/.nvm/nvm.sh
newman run saltTests/MQ\ remote\ connection\ with\ Salt\ Orchestrator.postman_collection.json -e saltTests/Notebook\ Salt\ test\ environment.postman_environment.json -g saltTests/My\ Workspace.postman_globals.json --insecure
