#!/bin/bash

saltapi_host=192.168.174.140
saltapi_port=8000
saltapi_user=juser
saltapi_pass=oneclick

saltapi_url="http://${saltapi_host}:${saltapi_port}"


resp=$(curl -sSk ${saltapi_url} \
    -b ./cookies.txt \
    -H 'Accept: application/json' \
    -H 'Content-type: application/json' \
    -d '
[
	{
		"client": "local_async",
		"tgt": "salt-minion1",
		"fun": "i_apicall.sls",
		"arg": "cmdb.openOrder",
		"kwarg": {
			"CallbackUrl": "http://api.corpintra.net/v2",
			"RequestId": "1212121",
			"pillar": {
				"INPUT": {
					"orderType": "CreateRemoteConnection",
					"extKey": "QM2.QM3.C0000002",
					"parameters": {
						"minionServerA": "salt-minion2",
						"minionServerB": "salt-minion3",
						"qmgrNameA": "QM2",
						"qmgrNameB": "QM3",
						"queueName": "C0000002",
						"qAliasA": "ARQ",
						"qAliasB": "ALQ"
					}
				}
			}
		}
	}
]
')
echo "#### $0 response: '$resp' ####"
