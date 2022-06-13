pipeline{

    agent {
        label 'master'
    }
    triggers {
        pollSCM "H/2 * * * *"
    }
    environment {
        imageName= "artebomba/webapp"
        AWS_ACCESS_KEY_ID     = credentials('ARTEM_AWS_USER_SECRET_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('ARTEM_AWS_USER_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION="eu-central-1"
    }

    options {
        disableConcurrentBuilds()
    }

    tools {
       terraform 'Terraform'
    }

    stages{

        stage('Clone repository'){
            steps{
                checkout scm
            }
        }

        stage('Build docker image'){
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

        stage('Deploy web application using Terraform and AWS') {
            steps{
                echo '=== Deploy web application using Terraform and AWS ==='
                sh('terraform -chdir=./Terraform init')
                catchError {
                    sh('terraform -chdir=./Terraform destroy --auto-approve')
                }
                sh('terraform -chdir=./Terraform apply --auto-approve')
                sh('sleep 300')
                sh('terraform -chdir=./Terraform destroy --auto-approve')
            }
        }
    }
}
