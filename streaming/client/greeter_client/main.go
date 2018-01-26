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

package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"os"

	pb "github.com/awalterschulze/grpcdemo/streaming/client/helloworld"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

func main() {
	addr := "streaming-server"
	// Set up a connection to the server.
	conn, err := grpc.Dial(addr+":50051", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewGreeterClient(conn)
	ctx, cancel := context.WithCancel(context.Background())
	helloClient, err := c.SayHello(ctx)
	if err != nil {
		log.Fatalf("did not connect to server: %v", err)
	}
	done := make(chan struct{})
	exited := false
	go func() {
		for {
			recv, err := helloClient.Recv()
			if err != nil {
				if exited {
					close(done)
					return
				}
				if err == io.EOF {
					close(done)
					return
				}
				if err == context.Canceled {
					close(done)
					return
				}
				panic(err)
			}
			fmt.Printf("server: %s\n", recv.Message)
		}
	}()
	for {
		line, _, err := bufio.NewReader(os.Stdin).ReadLine()
		if err != nil {
			log.Fatalf("could not readline: %v", err)
		}
		if string(line) == "exit" {
			exited = true
			break
		}
		if err := helloClient.Send(&pb.HelloRequest{Name: string(line)}); err != nil {
			log.Fatalf("could not send: %v", err)
		}
	}
	cancel()
	<-done
}
