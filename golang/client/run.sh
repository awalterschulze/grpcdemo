#!/bin/bash

(cd helloworld && protoc --go_out=plugins=grpc:. helloworld.proto)
go run ./greeter_client/main.go