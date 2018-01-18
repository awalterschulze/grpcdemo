#!/bin/bash

set -xe

(cd helloworld && protoc -I. -I/go/src/github.com/google/protobuf/src -I/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out=plugins=grpc:. helloworld.proto)
(cd helloworld && protoc -I. -I/go/src/github.com/google/protobuf/src -I/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --grpc-gateway_out=logtostderr=true:. helloworld.proto)
(cd helloworld && protoc -I. -I/go/src/github.com/google/protobuf/src -I/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --swagger_out=logtostderr=true:. helloworld.proto)
go run ./greeter_server/main.go & go run ./greeter_gateway/main.go