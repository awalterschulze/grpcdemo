/*
 *
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

//go:generate protoc -I ../helloworld --go_out=plugins=grpc:../helloworld ../helloworld/helloworld.proto

package main

import (
	"io"
	"log"
	"net"
	"time"

	pb "github.com/awalterschulze/grpcdemo/streaming/server/helloworld"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	port = ":50051"
)

// server is used to implement helloworld.GreeterServer.
type server struct{}

// SayHello implements helloworld.GreeterServer
func (s *server) SayHello(stream pb.Greeter_SayHelloServer) error {
	errChan := make(chan error)
	received := 0
	for {
		in, err := stream.Recv()
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}
		if err := stream.Send(&pb.HelloReply{Message: "Hoi " + in.Name}); err != nil {
			return err
		}
		received++
		go func(name string) {
			time.Sleep(time.Second * 5)
			if err := stream.Send(&pb.HelloReply{Message: "Hoe gaat het: " + name}); err != nil {
				errChan <- err
				return
			}
			time.Sleep(time.Second * 5)
			if err := stream.Send(&pb.HelloReply{Message: name + ", wil jij een iphone kopen?"}); err != nil {
				errChan <- err
				return
			}
		}(in.Name)
	}
	for i := 0; i < received; i++ {
		if err := <-errChan; err != nil {
			return err
		}
	}
	return nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterGreeterServer(s, &server{})
	// Register reflection service on gRPC server.
	reflection.Register(s)
	log.Printf("listening on %s", port)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
