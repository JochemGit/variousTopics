providePipelineVar() {
  if [ ! -z ${JENKINS_HOME+x} ]; then
    echo "$1" >> ./buffer
  fi
}

restorePipelineVars() {
  if [ ! -z ${JENKINS_HOME+x} ]; then
    cat ./buffer
  fi
}
