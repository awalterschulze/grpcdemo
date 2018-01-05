FROM golang:1.8.3-alpine3.6

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh wget protobuf

RUN go get -u google.golang.org/grpc
RUN go get -u github.com/golang/protobuf/protoc-gen-go

# RUN wget https://github.com/google/protobuf/releases/download/v$PROTOBUF_VERSION/protoc-3.5.0-linux-x86_64.zip
# RUN unzip protoc-3.5.0-linux-x86_64.zip
RUN protoc --help

RUN echo $GOPATH

RUN export PATH=$PATH:$GOPATH/bin

EXPOSE 50051

VOLUME [ "/go/src/google.golang.org/grpc/examples/helloworld" ]

WORKDIR /go/src/google.golang.org/grpc/examples/helloworld
