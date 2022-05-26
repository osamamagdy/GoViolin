FROM golang:1.18-alpine AS builder

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .


#RUN go test ./...

RUN go build -o app .

#This was the guide to use by the official documentation at golang dockerhub repository

FROM alpine

WORKDIR /app

COPY --from=builder /usr/src/app /app/


#This is mainly for doucmentation, to remember what port the app is running on.
EXPOSE 8080

CMD [ "./app" ]