run-python-server:
	(cd python && \
		docker build -t python-grpc-image . && \
		docker run --rm=true --name python-server-grpc-container --user="$(id -u):$(id -g)" -i -t -d -p 50051:50051 python-grpc-image)

stop-python-server:
	(cd python && docker stop python-server-grpc-container)

run-go-client:
	(cd golang/client && \
		docker build -t golang-grpc-client-image . && \
		docker run --rm=true --name golang-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/golang/client \
		-i -t --network=host golang-grpc-client-image ./run.sh)

run-go-server:
	(cd golang/server && \
		docker build -t golang-grpc-server-image . && \
		docker run --rm=true --name golang-server-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/golang/server \
		-d -p 50051:50051 \
		-i -t --network=host golang-grpc-server-image ./run.sh)

stop-go-server:
	(cd golang/server && docker stop golang-server-grpc-container)

run-gateway-client:
	(cd gateway/client && \
		docker build -t gateway-grpc-client-image . && \
		docker run --rm=true --name gateway-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/gateway/client \
		-i -t --network=host gateway-grpc-client-image ./run.sh)

run-gateway-server:
	(cd gateway/server && \
		docker build -t gateway-grpc-server-image . && \
		docker run --name gateway-server-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`:/go/src/github.com/awalterschulze/grpcdemo/gateway/server \
		-d \
		--rm=true \
		-p 9123:9123 \
		-i -t --network=host gateway-grpc-server-image ./run.sh)

# -p 50051:50051

stop-gateway-server:
	(cd gateway/server && docker stop gateway-server-grpc-container)
