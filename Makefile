run-python-server:
	(cd python && \
		docker build -t python-grpc-image . && \
		docker run --rm=true --name python-server-grpc-container --user="$(id -u):$(id -g)" -i -t -d -p 50051:50051 python-grpc-image)

stop-python-server:
	(cd python && docker stop python-server-grpc-container)

run-go-client:
	(cd golang && \
		docker build -t golang-grpc-image . && \
		docker run --rm=true --name golang-client-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`/client:/go/src/google.golang.org/grpc/examples/helloworld \
		-i -t --network=host golang-grpc-image ./run.sh)

run-go-server:
	(cd golang && \
		docker build -t golang-grpc-image . && \
		docker run --rm=true --name golang-server-grpc-container --user="$(id -u):$(id -g)" \
		--volume=`pwd`/server:/go/src/google.golang.org/grpc/examples/helloworld \
		-d -p 50051:50051 \
		-i -t --network=host golang-grpc-image ./run.sh)

stop-go-server:
	(cd golang && docker stop  golang-server-grpc-container)
