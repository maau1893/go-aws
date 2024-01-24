# Stage 1: Build the Go application for ARM64
FROM golang:1.17-alpine AS builder-arm64

WORKDIR /app

COPY . .

# Build for ARM64
RUN CGO_ENABLED=0 GOARCH=arm64 go build -o myapp-arm64

# Stage 2: Build the Go application for AMD64
FROM golang:1.17-alpine AS builder-amd64

WORKDIR /app

COPY . .

# Build for AMD64
RUN CGO_ENABLED=0 GOARCH=amd64 go build -o myapp-amd64

# Stage 3: Create the final image with both AMD64 and ARM64 support
FROM alpine:latest

WORKDIR /app

# Copy only the necessary artifacts from the ARM64 builder image
COPY --from=builder-arm64 /app/myapp-arm64 .

# Copy only the necessary artifacts from the AMD64 builder image
COPY --from=builder-amd64 /app/myapp-amd64 .

# Expose a port if your application listens on a specific port
EXPOSE 8080

# Command to run the executable based on the architecture
CMD [ "./myapp-amd64" ]
