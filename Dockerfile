FROM golang:1.17 AS builder

ENV GO111MODULE=on \
GOPROXY=https://goproxy.cn,direct \
CGO_ENABLED=0 \
GOOS=linux \
GOARCH=amd64

WORKDIR /app
COPY . .
RUN ./build.sh

FROM ubuntu:latest
WORKDIR /app
COPY --from=builder /app/teamgramd/ /app/
RUN apt update -y && apt install -y ffmpeg && chmod +x /app/docker/entrypoint.sh
ENTRYPOINT /app/docker/entrypoint.sh
