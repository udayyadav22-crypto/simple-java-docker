pipeline {
    agent any

    environment {
        IMAGE_NAME = "simple-java-docker"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/udayyadav22-crypto/simple-java-docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Run Container') {
            steps {
                sh """
                    docker rm -f simple-java-app || true
                    docker run -d --name simple-java-app ${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 5
                    docker logs simple-java-app
                """
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker rm -f simple-java-app || true"
            }
        }
    }

    post {
        success {
            echo "Build Successful!"
        }

        failure {
            echo "Build Failed!"
        }

        always {
            cleanWs()
        }
    }
}
