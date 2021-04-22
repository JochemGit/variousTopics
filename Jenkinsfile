def stepsToRun = [:]

pipeline {
    agent none

    stages {
        stage (&quot;Create VMs&quot;){
            steps {
                script {
                    for (int i = 1; i &lt; 3; i++) {
                        stepsToRun[&quot;VM${i}&quot;] = prepareVM(&quot;VM${i}&quot;)
                    }
                    parallel stepsToRun
                }
            }
        }
        stage (&quot;Test cases&quot;){
            steps {
                script {
                    stepsToRun = [:]
                    for (int i = 1; i &lt; 5; i++) {
                        stepsToRun[&quot;Step${i}&quot;] = prepareStage(&quot;Step${i}&quot;)
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
            stage(&quot;Create VM&quot;) {
                echo &quot;start 1&quot;
                sleep 3
                if (name == &quot;VM2&quot;) {
                    sleep 2
                    // sh &apos;exit -1&apos;
                }
                echo &quot;done 1&quot;
            }
            stage(&quot;Get QM&quot;) {
                echo &quot;start 2&quot;
                sleep 5
                echo &quot;done 2&quot;
            }
        }
    }
}

def prepareStage(def name) {
    return {
        stage (name) {
            stage(&quot;1&quot;) {
                echo &quot;start 1&quot;
                sleep 3
                if (name == &quot;Step2&quot;) {
                    sleep 2
                    //sh &apos;exit -1&apos;
                }
                echo &quot;done 1&quot;
            }
            stage(&quot;2&quot;) {
                echo &quot;start 2&quot;
                sleep 5
                echo &quot;done 2&quot;
            }
        }
    }
}
