FROM debian:jessie

RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv git

RUN python -m pip install grpcio
RUN python -m pip install grpcio-tools

RUN git clone -b v1.8.0 https://github.com/grpc/grpc

EXPOSE 50051

WORKDIR /grpc/examples/python/helloworld
CMD ["python", "./greeter_server.py"]
