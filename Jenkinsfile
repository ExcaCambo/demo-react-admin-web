
def reposName = 'registry.digitalocean.com/narith-registry'
def appName = 'react-admin-web'
def version = '1.0.0-default'
def port = 30100

pipeline {

  agent { label 'api-node-02' }
  tools { nodejs 'NODEJS-1614' }

  stages {    
    stage('Preparation') {
      steps {
        script {
          version=sh( script: 'bash scripts/app-version.sh', returnStdout: true ).trim()
        }
        echo "Information | name: ${appName}, version: ${version}"
      }
    }

    stage('Build') {
      steps {
        echo 'Running Build ...'
        script {
          sh 'bash scripts/react-build.sh'
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        script {
          echo 'Code Smell Scanner'
          def scannerHome = tool 'SonarScanner';
          withSonarQubeEnv('devops-sonarqube-01') {
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          echo 'Build Docker Image'
          sh "bash scripts/docker-build.sh ${reposName} ${version} ${port}"
        }
      }
    }

    stage('Upload Docker Image') {
      steps {
        script {
          echo 'Push to Digital Ocean Registry'
          sh "bash scripts/docker-upload.sh ${reposName} ${version}"
        }
      }
    }

    stage('Deploy Docker App') {
      steps {
        script {
          echo 'Deploy Application'
          sh "bash scripts/docker-deploy.sh ${version}"
          catchError(buildResult: 'UNSTABLE') {
            echo 'Build Failed ...'
          }
        }
      }
    }
  }

  post {
    always {
      echo 'Final Stage: Notification'
      script {
        def contenBody = """
<b>App</b>: ${appName} 
<b>Version</b>: ${version}
<b>Status</b>: ${currentBuild.currentResult}"""
        def parameters = [
          [$class: 'StringParameterValue', name: 'HEADER', value: "WEB DEPLOYMENT"],
          [$class: 'StringParameterValue', name: 'BODY', value: "${contenBody}"],
        ]
        build job: 'Notifier/send-telegram-message', parameters: parameters
      }
    }
  }
}
