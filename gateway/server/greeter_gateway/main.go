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
	defer func() {
		log.Printf("stopped gateway")
	}()
	if err := http.ListenAndServe(":9123", mux); err != nil {
		log.Fatal(err)
	}

	// http.HandleFunc("/v1/helloworld/sayhello", func(w http.ResponseWriter, r *http.Request) {
	// 	log.Printf("Hello, %q", html.EscapeString(r.URL.Path))
	// })

	// log.Fatal(http.ListenAndServe(":9123", nil))
}
