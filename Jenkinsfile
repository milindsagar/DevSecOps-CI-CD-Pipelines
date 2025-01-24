pipeline {
   
    agent any
   
    tools {
        jdk 'jdk17'
        maven 'maven3'
        git
    }

    stages{
        stage ('Cleaning Workspace'){
            steps{
                cleanWs()
            }
        }
        
        stage ('checkout SCM') {
            steps {
                git 'https://github.com/milindsagar/DevSecOps-CI-CD-Pipelines.git'
            }
        }
        
        stage ('Compiling Maven Code') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage ('maven Test') {
            steps {
                sh 'mvn test'
            }
        }
    }
}
