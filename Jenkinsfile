def stepsToRun = [:]
testenv = [:]

pipeline {
    agent any

    stages {
        stage ("Create VMs"){
            steps {
                script {
                    for (int i = 1; i < 3; i++) {
                        stepsToRun["VM${i}"] = prepareVM("VM${i}")
                    }
                    parallel stepsToRun
                }
            }
        }
        stage ("Test cases"){
            steps {
                script {
                    stepsToRun = [:]
                    for (int i = 1; i < 5; i++) {
                        stepsToRun["Testcase${i}"] = prepareStage("Testcase${i}")
                    }   
                    parallel stepsToRun
                }
            }
        }
    }
}

def prepareVM(def name) {
    return {
        stage (name) {
            stage("Create VM") {
                echo name + " - Create VM - Start"
                if (name == "VM2") {
                    ret = sh (
                        script: "$WORKSPACE/tools/execWithCallback.py 8001 '{ \"hostname\": \"server2.dummy.net\" }'",
                        returnStdout:  true
                    ).trim()
                } else {
                    ret = sh (
                        script: "$WORKSPACE/tools/execWithCallback.py 8000 '{ \"hostname\": \"server1.dummy.net\" }'",
                        returnStdout:  true
                    ).trim()
                }
                echo "Server received: " + ret
                def pjson = new groovy.json.JsonSlurper().parseText(ret)
                testenv["minion${name}"] = pjson["hostname"]
                echo name + " - Create VM - Done"
            }
            stage("Get QM") {
                echo name + " - Get QM - Start"
                if (name == "VM2") {
                    ret = sh (
                        script: "$WORKSPACE/tools/execWithCallback.py 8001 '{ \"qmname\": \"QM2\" }'",
                        returnStdout:  true
                    ).trim()
                } else {
                    ret = sh (
                        script: '$WORKSPACE/tools/execWithCallback.py 8000 "{ \\\"qmname\\\": \\\"QM1\\\" }"',
                        returnStdout:  true
                    ).trim()
                }
                echo "Server received: " + ret
                def pjson = new groovy.json.JsonSlurper().parseText(ret)
                testenv["qm${name}"] = pjson["qmname"]
                echo name + " - Get QM - Done"
            }
        }
    }
}

def prepareStage(def name) {
    return {
        stage (name) {
            stage("1") {
                echo "start 1"
                if (name != "Testcase1") {
                    sleep 3
                }
                echo "Variables in test environment!"
                for (element in testenv) {
                    echo "${element.key}: ${element.value}"
                }
                sh "TEST1=TEST1 printenv|sort"
                echo "done 1"
            }
            stage("2") {
                echo "start 2"
                sleep 1
                echo "done 2"
            }
        }
    }
}
