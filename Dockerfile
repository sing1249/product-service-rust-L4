# Use the official Rust image to build the product-service
FROM rust:1.70 as builder

WORKDIR /usr/src/product-service

# Copy the project files and dependencies
COPY . .

# Build the product-service
RUN cargo build --release

# Use a smaller image for running the service
FROM debian:bullseye-slim

WORKDIR /usr/src/app

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/product-service/target/release/product-service /usr/local/bin/

# Expose the service port
EXPOSE 3030

# Set environment variables for the product-service
ENV PORT=3030

# Run the product-service
CMD ["product-service"]