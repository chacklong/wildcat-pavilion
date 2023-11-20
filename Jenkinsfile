pipeline {
    agent any

    environment {
        DOCKER_IMAGE = '3066199080400/wildcat-pavilion'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            steps {
                sh 'npm install'
                sh 'npm run build'
                // 添加测试命令
                // sh 'npm run test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def branchTag = (env.BRANCH_NAME == 'master') ? 'latest' : 'dev'
                    sh "docker build -t ${DOCKER_IMAGE}:${branchTag} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
                    script {
                        def branchTag = (env.BRANCH_NAME == 'master') ? 'latest' : 'dev'
                        sh "docker push ${DOCKER_IMAGE}:${branchTag}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        // 部署生产环境
                        sh 'docker compose -f docker-compose.prod.yml up -d'
                    } else {
                        // 部署开发环境
                        sh 'docker compose -f docker-compose.dev.yml up -d'
                    }
                }
            }
        }
    }
}
