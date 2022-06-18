# GRPC Demo

A GRPC Demo using the Go and Python examples, but running them in dockers.
This also includes a demo with grpc-gateway in the gateway folder.

The slides for the presentation can be found [here](https://slides.com/awalterschulze/grpc-api)

## Cross language Demo

```
$ make run-python-server
$ make run-go-client
$ make stop-python-server
```

The golang client code is available in [golang/client](https://github.com/awalterschulze/grpcdemo/tree/master/golang/client) to play with.  The python client is the default one provided by grpc examples.

## Backwards compatibility Demo

Edit the [golang/client/helloworld/helloworld.proto](https://github.com/awalterschulze/grpcdemo/blob/master/golang/client/helloworld/helloworld.proto) or [golang/server/helloworld/helloworld.proto](https://github.com/awalterschulze/grpcdemo/blob/master/golang/server/helloworld/helloworld.proto) file and then run:

```
$ make run-go-server
$ make run-go-client
$ make stop-go-server
```

I also encourage you to edit the [golang/client/greeter_client/main.go](https://github.com/awalterschulze/grpcdemo/blob/master/golang/client/greeter_client/main.go) and [golang/server/greeter_server/main.go](https://github.com/awalterschulze/grpcdemo/blob/master/golang/server/greeter_server/main.go) files.
This will allow you to play even more with the backwards compatibility.

## Gateway Demo

```
$ make run-gateway-server
$ make run-gateway-client
$ make stop-gateway-server
```

The client in this case is a simple curl

```
$ curl -X POST -k http://localhost:9123/v1/helloworld/sayhello -H "Content-Type: text/plain" -d '{"name": "old school"}'
```

You can see the output swagger in [gateway/server/helloworld/helloworld.swagger.json](https://raw.githubusercontent.com/awalterschulze/grpcdemo/master/gateway/server/helloworld/helloworld.swagger.json)


## Streaming Demo

```
$ make run-streaming-server
$ make run-streaming-client
$ make stop-streaming-server
```

The client expects you to type in multiple names and separated by newline characters.
The server will then send back three messages each with a 5 second delay.

