pipeline {
    agent any
    environment{
        LOGIN_SERVER = "osamamagdy"
    }

    stages {

        stage('run go tests') {
            steps {
                echo "========Testing Go files ========"
                sh """
                    go mod vendor
                    go mod download
                    go mod verify
                    go test ./...
                """    
            }
            post {
                success {
                    echo "========Go tests success ========"
                    slackSend (color:"#00FF00", message: " All tests passed")
                }
                failure {
                    echo "========Go tests failed========"
                    slackSend (color:"#FF0000", message: "Some tests failed")
                }
           }
        }



//You can use the docker plugin instead (no much difference in our case)
        stage('docker build') {
            steps {
                echo "========docker build ========"
                sh """
                    docker build -t $LOGIN_SERVER/goviolin:latest .
                """    
            }
            post {
                success {
                    echo "========docker build success ========"
                    slackSend (color:"#00FF00", message: "Building Image success")
                }
                failure {
                    echo "========docker build failed========"
                    slackSend (color:"#FF0000", message: "Building Image failure")
                }
           }
        }

        stage('docker push') {
            steps {
                echo "========docker push ========"
                withCredentials([usernamePassword(credentialsId: 'docker-secret', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                {
                sh """
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push $LOGIN_SERVER/goviolin:latest
                """    
                }
            }
            post {
                success {
                    echo "========docker push success ========"
                    slackSend (color:"#00FF00", message: "Pushing Image success")
                }
                failure {
                    echo "========docker push failed========"
                    slackSend (color:"#FF0000", message: "Pushing Image failure")
                }
           }
        }
        
        stage('Run app') {
            steps {
                echo "========docker run ========"
                sh """
                    docker stop GoViolin
                    docker rm GoViolin
                    docker run -p 80:8080 -d --name=GoViolin $LOGIN_SERVER/goviolin:latest
                """    
            }
            post {
                success {
                    echo "========app is deployed ========"
                    slackSend (color:"#00FF00", message: "app is deployed successfully")
                }
                failure {
                    echo "========docker push failed========"
                    slackSend (color:"#FF0000", message: "app deployment failure")
                }
           }
        }
        



    }
} 
