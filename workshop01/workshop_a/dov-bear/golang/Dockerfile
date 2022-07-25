# first container for building the binary
ARG GOLANG_VERSION="1.18-alpine3.16"
ARG ALPINE_VERSION="3.16"
FROM golang:${GOLANG_VERSION} AS builder

WORKDIR /app

# add the files
ADD go.mod .
ADD go.sum .
ADD main.go .

# build the application
# /app/main
RUN go build -o main .

# deployment container
FROM alpine:${ALPINE_VERSION}

# Install curl
RUN apk --no-cache add curl

WORKDIR /app

# copy the binary from builder
COPY --from=builder /app/main /app/main

# copy public and templates into the container
ADD public public
ADD templates templates

USER 1000
ENV PORT=5000

EXPOSE ${PORT}

ENTRYPOINT [ "./main" ]
