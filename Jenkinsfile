pipeline {
    agent any

    tools {
        jdk 'jdk17'          // Ensure 'jdk17' is configured in Jenkins
        maven 'maven3'       // Ensure 'maven3' is configured in Jenkins
    }

    stages {
        stage('Cleaning Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout SCM') {
            steps {
                git 'https://github.com/milindsagar/DevSecOps-CI-CD-Pipelines.git'
            }
        }

        stage('Compiling Maven Code') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Run Maven Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            e        }
    }cho 'Pipeline failed!'

}
