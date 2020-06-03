FROM golang:1.14.3-alpine3.11 AS build_base

RUN apk add --no-cache git

# Set the Current Working Directory inside the container
WORKDIR /tmp/webappone

# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod .
COPY go.sum .
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go mod download

COPY . .

# Unit tests
RUN CGO_ENABLED=0 go test -v

# Build the Go app
RUN go build -o ./out/webappone .

# Start fresh from a smaller image
FROM alpine:3.11
RUN apk add ca-certificates

COPY --from=build_base /tmp/webappone/out/webappone /app/webappone

# This container exposes port 8080 to the outside world
EXPOSE 9999

# Run the binary program produced by `go install`
CMD ["/app/webappone"]