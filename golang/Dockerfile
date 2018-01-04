FROM golang:1.8.3-alpine3.6

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN go get -u google.golang.org/grpc
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN export PATH=$PATH:$GOPATH/bin

EXPOSE 50051

WORKDIR $GOPATH/src/google.golang.org/grpc/examples/helloworld
CMD ["go", "run", "greeter_client/main.go"]