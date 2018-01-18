FROM golang:1.8.3-alpine3.6

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh wget protobuf curl

RUN mkdir -p /go/src/github.com/awalterschulze/grpcdemo/gateway/client

VOLUME [ "/go/src/github.com/awalterschulze/grpcdemo/gateway/client" ]

WORKDIR /go/src/github.com/awalterschulze/grpcdemo/gateway/client