pipeline {
    agent any

    environment {
        IMAGE_NAME = "simple-java-docker"
        IMAGE_TAG  = "latest"
        UAT_IP = "10.0.1.50" // <- Ithe tumcha UAT Private IP taka
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/udayyadav22-crypto/simple-java-docker.git'
            }
        }

        stage('Java Build') {
            steps {
                echo "--- Java Build suru ---"
                sh '''
                    ls -l src/
                    javac src/Main.java
                    echo "Java Compile SUCCESS"
                    java -cp src Main
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "--- Docker Build suru ---"
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Deploy to UAT') {
            steps {
                echo "--- UAT var Deploy ---"
                sshagent(['uat-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${UAT_IP} '
                            cd ~/simple-java-docker || git clone https://github.com/udayyadav22-crypto/simple-java-docker.git ~/simple-java-docker &&
                            cd ~/simple-java-docker &&
                            git pull origin main &&
                            javac src/Main.java &&
                            docker rm -f simple-java-app || true &&
                            docker build -t ${IMAGE_NAME}:${IMAGE_TAG} . &&
                            docker run -d -p 8080:8080 --name simple-java-app ${IMAGE_NAME}:${IMAGE_TAG} &&
                            docker ps
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Build Successful! UAT var Deploy jhala!"
        }
        failure {
            echo "Build Failed!"
        }
        always {
            cleanWs()
        }
    }
}
