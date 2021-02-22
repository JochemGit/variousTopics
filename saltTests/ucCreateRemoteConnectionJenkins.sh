#!/bin/bash

. /home/juser/.nvm/nvm.sh
newman run ./MQ\ remote\ connection\ with\ Salt\ Orchestrator.postman_collection.json -e ./Notebook\ Salt\ test\ environment.postman_environment.json -g ./My\ Workspace.postman_globals.json --insecure
