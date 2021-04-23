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
                echo "start 1"
                //sleep 3
                if (name == "VM2") {
                    sh '$WORKSPACE/tools/execWithCallback.py 8001'
                } else {
                    sh '$WORKSPACE/tools/execWithCallback.py'
                }
                echo "done 1"
            }
            stage("Get QM") {
                echo "start 2"
                sleep 5
                echo "done 2"
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
