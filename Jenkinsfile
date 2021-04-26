def stepsToRun = [:]

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
                        stepsToRun["Step${i}"] = prepareStage("Step${i}")
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
                //sleep 3
                if (name == "VM2") {
                    sh '$WORKSPACE/tools/execWithCallback.py 8001 "{ \'hostname\': \'server2.dummy.net\' }"'
                } else {
                    sh '$WORKSPACE/tools/execWithCallback.py 8000 "{ \'hostname\': \'server1.dummy.net\' }"'
                }
                echo name + " - Create VM - Done"
            }
            stage("Get QM") {
                echo name + " - Get QM - Start"
                //sleep 3
                if (name == "VM2") {
                    sh '$WORKSPACE/tools/execWithCallback.py 8001 "{ \'qmname\': \'QM2\' }"'
                } else {
                    sh '$WORKSPACE/tools/execWithCallback.py 8000 "{ \'qmname\': \'QM1\' }"'
                }
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
                sleep 3
                if (name == "Step2") {
                    sleep 2
                    //sh 'exit -1'
                }
                echo "done 1"
            }
            stage("2") {
                echo "start 2"
                sleep 5
                echo "done 2"
            }
        }
    }
}
