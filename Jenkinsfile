pipeline{

    agent {
        label 'master'
    }
    triggers {
        pollSCM "* * * * *"
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
                    echo '=== Building Docker Image ==='
                    app = docker.build("${imageName}")
                }
            }
        }

        stage('Push docker image to DockerHub') {
            steps {
                echo '=== Pushing Docker Image ==='
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    SHORT_COMMIT = "${GIT_COMMIT_HASH[0..7]}"
                    docker.withRegistry('https://registry.hub.docker.com', 'Dockerhub') {
                        app.push("$SHORT_COMMIT")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Delete docker image locally') {
            steps{
                echo '=== Delete the local docker images ==='
                sh("docker rmi -f ${imageName}:latest || :")
                sh("docker rmi -f ${imageName}:$SHORT_COMMIT || :")
            }
        }
    }
}
