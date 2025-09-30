pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yourdockerhubusername/myproject"
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull the code from your GitHub repo
                git branch: 'main', url: 'git@github.com:yourusername/myproject.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:latest .'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE:latest
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh """
                docker stop myproject || true
                docker rm myproject || true
                docker run -d -p 8080:80 --name myproject $DOCKER_IMAGE:latest
                """
            }
        }
    }
}
