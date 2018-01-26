run-python-server:
	docker-compose --project-name grpcdemo up -d python-server-grpc

stop:
	docker-compose --project-name grpcdemo down --remove-orphans --volumes

run-go-python-client:
	(cd golang/client && \
		docker build -t golang-grpc-client-image . && \
		docker run --rm=true --name golang-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/golang/client \
		-i -t --network=grpcdemo_default golang-grpc-client-image ./run.sh python-server-grpc)

run-go-go-client:
	(cd golang/client && \
		docker build -t golang-grpc-client-image . && \
		docker run --rm=true --name golang-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/golang/client \
		-i -t --network=grpcdemo_default golang-grpc-client-image ./run.sh go-server-grpc)

run-go-server:
	docker-compose --project-name grpcdemo up -d go-server-grpc

run-gateway-client:
	(cd gateway/client && \
		docker build -t gateway-grpc-client-image . && \
		docker run --rm=true --name gateway-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/gateway/client \
		-i -t --network=grpcdemo_default gateway-grpc-client-image ./run.sh)

run-gateway-server:
	docker-compose --project-name grpcdemo up -d gateway-server

run-streaming-server:
	docker-compose --project-name grpcdemo up -d streaming-server

run-streaming-client:
	(cd streaming/client && \
		docker build -t streaming-grpc-client-image . && \
		docker run --rm=true --name streaming-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/streaming/client \
		-i -t --network=grpcdemo_default streaming-grpc-client-image ./run.sh)