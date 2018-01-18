package main

import (
	"log"
	"net/http"

	gw "github.com/awalterschulze/grpcdemo/gateway/server/helloworld"
	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

func main() {
	mux := runtime.NewServeMux()
	if err := gw.RegisterGreeterHandlerFromEndpoint(context.Background(), mux, "localhost:50051", []grpc.DialOption{grpc.WithInsecure()}); err != nil {
		log.Fatal(err)
	}
	log.Printf("running gateway...")
	if err := http.ListenAndServe(":9123", mux); err != nil {
		log.Fatal(err)
	}
}
