pipeline {
    agent any
    environment{
        LOGIN_SERVER = "osamamagdy"
        // Ensure the desired Go version is installed
        root = tool type: 'go', name: 'GO 1.18' //Use GO 1.18 as it is the same used in building docker image
    }
    stages {

        stage('run go tests') {
            steps {
                echo "========Testing Go files ========"

                // Export environment variables pointing to the directory where Go was installed and run steps
                withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
                    sh """
                        go version
                        go mod vendor
                        go mod download
                        go mod verify
                        go test ./...
                    """    
                }
            }
            post {
                success {
                    echo "========Go tests success ========"
                    // slackSend (color:"#00FF00", message: " All tests passed")
                }
                failure {
                    echo "========Go tests failed========"
                    // slackSend (color:"#FF0000", message: "Some tests failed")
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
                    // slackSend (color:"#00FF00", message: "Building Image success")
                }
                failure {
                    echo "========docker build failed========"
                    // slackSend (color:"#FF0000", message: "Building Image failure")
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
                    // slackSend (color:"#00FF00", message: "Pushing Image success")
                }
                failure {
                    echo "========docker push failed========"
                    // slackSend (color:"#FF0000", message: "Pushing Image failure")
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
                    // slackSend (color:"#00FF00", message: "app is deployed successfully")
                }
                failure {
                    echo "========docker push failed========"
                    // slackSend (color:"#FF0000", message: "app deployment failure")
                }
           }
        }
        



    }
} 
