# ---- Build Stage ----
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Install CA certificates
RUN apk add --no-cache ca-certificates

# Copy go mod files and download dependencies
COPY go.mod ./
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o hello-service

# ---- Runtime Stage ----
FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/hello-service .

EXPOSE 8080

USER nonroot:nonroot

CMD ["./hello-service"]
