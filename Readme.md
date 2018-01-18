# GRPC Demo

A GRPC Demo using the Go and Python examples, but running them in dockers.

## Cross language Demo

```
$ make run-python-server
$ make run-go-client
$ make stop-python-server
```

## Backwards compatibility Demo

```
$ make run-go-server
$ make run-go-client
$ make stop-go-server
```

## Gateway Demo

```
$ make run-gateway-server
$ make run-gateway-client
$ make stop-gateway-server
```