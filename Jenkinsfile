pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
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

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=Petshop -Dsonar.projectName=Petshop'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        
        stage('Building war file using Maven') {
            steps {
                sh 'mvn clean install -DskipTests=true'
            }
        }
        
        stage('OWASP Dependency Checking') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --format XML', odcInstallation: 'dependency-check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage('Verify Presence of mvnw') {
            steps {
                sh 'ls -la'  // List files in the current directory to verify mvnw file presence
            }
        }

        stage('Verify Docker Image') {
            steps {
                sh "docker images"  // List Docker images to confirm if sagardaw/petshop:01 is built
            }
        }

        stage('Building and Pushing to Docker Hub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t sagardaw/petshop:02 . --no-cache --pull"  // Build with no cache to ensure fresh image
                        sh "docker push sagardaw/petshop:02"
                    }
                }
            }
        }

        stage('Check if TRIVY is Installed') {
            steps {
                sh 'trivy --version'  // Verify if TRIVY is installed and accessible
            }
        }

        stage('Image Scanning using TRIVY') {
            steps {
                sh "trivy image --no-progress sagardaw/petshop:02 > trivy.txt; cat trivy.txt"  // Show the scan output
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
            echo 'Pipeline failed!'
        }
    }
}
