# Base Go image
FROM golang:latest AS builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o authApp ./cmd/api

RUN chmod +x /app/authApp

# Build a tiny Docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/authApp /app

CMD ["/app/authApp"]
