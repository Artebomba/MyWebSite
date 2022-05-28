pipeline{

    agent {
        label 'master'
    }
    environment {
        imageName= "artebomba/webapp"
    }

    stages{
        stage('Clone repository'){
            steps{
                checkout scm
            }
        }

        stage('Build'){
            steps{
                script {
                    docker.build("${imageName}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push docker image to DockerHub') {
            steps{
                withDockerRegistry(credentialsId: 'Dockerhub', url: 'https://index.docker.io/v1/') {
                    sh 'docker push ${imageName}:${BUILD_NUMBER}'
                }
            }
        }
        stage('Delete docker image locally') {
            steps{
                sh 'docker rmi ${imageName}:${BUILD_NUMBER}'
            }
        }
    }
}
