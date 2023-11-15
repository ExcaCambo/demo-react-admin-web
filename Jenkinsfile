def appName = 'react-admin-web'
def version = '1.0.0-default'

pipeline {
  agent { label 'api-node-02' }

  stages {    
    stage('Preparation') {
      steps {
        echo "Information | name: ${appName}, version: ${version}"
      }
    }
  }
}