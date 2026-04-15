FROM golang:1.25.4-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Validate generated package compiles.
RUN go build ./...

FROM alpine:3.21

WORKDIR /app

COPY --from=build /app /app

CMD ["sh", "-c", "echo 'be-proto-gen artifacts image is ready'; sleep infinity"]
