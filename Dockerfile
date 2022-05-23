FROM golang:1.18

WORKDIR /usr/src/app

COPY . .
RUN go mod init
RUN go build -v -o /usr/local/bin/app .

EXPOSE 8080
#This is mainly for doucmentation, to remember what port the app is running on.

CMD ["app"]


#This was the guide to use by the official documentation at golang dockerhub repository
# start go mod init was the only required change as there is no dependencies
# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
# COPY go.mod go.sum ./
# RUN go mod download && go mod verify
