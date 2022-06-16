# GoViolin

GoViolin is a web app written in Go that helps with violin practice.

Currently hosted at http://3.64.91.117/

GoViolin allows practice over both 1 and 2 octaves.

Contains:
* Major Scales
* Harmonic and Melodic Minor scales
* Arpeggios
* A set of two part scale duet melodies by Franz Wohlfahrt


Feel free to create a pull request, add any tones or general suggestions.
------------------------------------------------------------------


💻 Technologies & Tools
--------------

* HTML5/CSS3
* Go
* Docker
* Jenkins
* Kubernetes
* Terraform

To Build the application, 
------------------------
- Install Go (v1.15 or higher preferred)
- Go to the project directory
```
    cd GoViolin
```

Then, install used packages
---------------------------

```
    go mod download
    go mod verify
```

Run tests we made for the application
----------------------------

```
go test ./...
```

Export the port you want the app to listen to and build 
----------------------

```
export PORT=5000
go build -o app .
```

Note: The app will be listening on port 8080 by default if you didn't export $PORT

Now, you can run the binary and listen to the beutiful violin
------------------------------------------------------------------------------------------

```
./app
```
Go to localhost:5000 (or the port number you specified)

## Build using docker image

To Build the application, directly without using go
------------------------
- Install docker
- Go to the project directory
```
    cd GoViolin
```

Then, build the docker file
---------------------------

```
    docker build -t <your_docker_id>/<your_repository_name>:<tag> .
```

Run tests we made for the application during building the docker image
----------------------------
Uncomment the following line in the docker file 

```
#RUN go test ./...
```

Note: To make smaller and more efficient in size, we used multi-stage docker file.
So, after building the app, we remove any other files and run the application

Run the docker container using this image. Remeber port mapping as you will use it.
----------------------

```
docker run -p <HOST_PORT>:8080 -d --name= goviolin <your_docker_id>/<your_repository_name>:<tag>
```

Note: The app will be listening on port 8080 by default inside the docker container if you didn't export $PORT inside the docker file (in most cases this doesn't matter)


Note: You can directly use my public docker image directly


```
docker run -p <HOST_PORT>:8080 -d --name= goviolin osamamagdy/goviolin:latest
```


Now, you can listen to the beutiful violin
------------------------------------------------------------------------------------------

Go to localhost:5000 (or the port number you specified in port mapping)



## Create Jenkins pipeline to apply CI/CD

First, you need to install jenkins and configure jenkins
------------------------
- Install Jenkins
- Install the following plugins:

```
https://plugins.jenkins.io/golang/
https://plugins.jenkins.io/slack/
```

Then, configure your plugins and credentials
---------------------------

- Follow the official documentation of each plugin installed ( for go plugin, give it the name in the jenkins file)

- Add your docker hub credentials under the name 'docker-secret' to be apple to push images at new releases


Create a multi-branch pipeline
----------------------------
- In the Jenkins dashboard, add new item
- Select a multi-branch pipeline add provide the git repository url in the required section
- To enable triggering, you can either use hooks from your git repo with each commit or PR. Or you can activate periodically scanning in the pipeline configuration 


The rest is made for you
----------------------------
- Try to look on the Jenkinsfile and modify steps you want 


## Use Kubernetes

If you don't have a kubernetes cluster attached with kubectl
------------------------
- You can use minikube to run a single-node cluster

Go to k8s directory
------------------------
```
cd k8s
```

Apply the two files (deployment for running the container and service to route traffic)
------------------------
```
kubectl apply -f goviolin-deployment.yaml
kubectl apply -f goviolin-service.yaml

```


## Use Terraform

- You can use terraform to provision an EC2 instance on aws to deploy the applications

- Go to the `Terraform` directory and follow the instructions in the `README.md` there


## Project file structure 
```
GoViolin
├─ .dockerignore
├─ .gitignore
├─ Dockerfile
├─ Jenkinsfile
├─ Procfile
├─ README.md
├─ Terraform
│  ├─ README.md
│  ├─ host.sh
│  └─ slave
│     ├─ .env
│     ├─ .terraform.lock.hcl
│     ├─ slave.pem
│     ├─ slave.sh
│     ├─ slave.tf
│     └─ terraform.tfstate
├─ css
│  └─ main.css
├─ duet.go
├─ go.mod
├─ go.sum
├─ home.go
├─ home_test.go
├─ img
├─ k8s
│  ├─ goviolin-deployment.yaml
│  └─ goviolin-service.yaml
├─ main.go
├─ mp3
├─ scale.go
├─ scale_test.go
├─ templates
│  ├─ duets.html
│  ├─ home.html
│  └─ scale.html
└─ vendor
   └─ modules.txt

```
