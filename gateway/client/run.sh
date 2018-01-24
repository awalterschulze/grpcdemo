#!/bin/bash

curl -X POST -k http://gateway-server:9123/v1/helloworld/sayhello -H "Content-Type: text/plain" -d '{"name": "old school"}'; echo

