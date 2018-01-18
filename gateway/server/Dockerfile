FROM golang:1.8.3-alpine3.6

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh wget protobuf

RUN mkdir -p /go/src/github.com/google/protobuf
RUN git clone https://github.com/google/protobuf /go/src/github.com/google/protobuf
RUN go get -u google.golang.org/grpc
RUN go get -u github.com/golang/protobuf/protoc-gen-go
# RUN mkdir -p /go/src/github.com/grpc-ecosystem/grpc-gateway
# RUN git clone https://github.com/grpc-ecosystem/grpc-gateway /go/src/github.com/grpc-ecosystem/grpc-gateway
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

# RUN wget https://github.com/google/protobuf/releases/download/v$PROTOBUF_VERSION/protoc-3.5.0-linux-x86_64.zip
# RUN unzip protoc-3.5.0-linux-x86_64.zip
RUN protoc --help

RUN echo $GOPATH

RUN export PATH=$PATH:$GOPATH/bin

# EXPOSE 50051
EXPOSE 9123

RUN mkdir -p /go/src/github.com/awalterschulze/grpcdemo/gateway/server

VOLUME [ "/go/src/github.com/awalterschulze/grpcdemo/gateway/server" ]

WORKDIR /go/src/github.com/awalterschulze/grpcdemo/gateway/server
