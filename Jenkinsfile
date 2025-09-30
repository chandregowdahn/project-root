pipeline {
    agent any
    environment {
        DOCKERHUB = credentials('dockerhub-creds')
        IMAGE = "yourdockerhubusername/myproject"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:chandregowdahn/project-root.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE:latest .'
            }
        }
        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
                sh 'docker push $IMAGE:latest'
            }
        }
        stage('Deploy Container') {
            steps {
                sh 'docker rm -f myapp || true'
                sh 'docker run -d -p 8080:80 --name myapp $IMAGE:latest'
            }
        }
    }
}
