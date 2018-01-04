runserver:
	(cd python && docker build -t python-grpc-image . && docker run --rm=true --name python-grpc-container --user="$(id -u):$(id -g)" -i -t -d -p 50051:50051 python-grpc-image)

stopserver:
	(cd python && docker stop python-grpc-container)

runclient:
	(cd golang && docker build -t golang-grpc-image . && docker run --rm=true --name golang-grpc-container --user="$(id -u):$(id -g)" -i -t --network=host golang-grpc-image)
