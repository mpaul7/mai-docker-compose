# Base image with Python 3.11 (Ubuntu 24.04 compatible)
FROM python:3.11-slim

WORKDIR /app

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copy package files
COPY . /app/mai_streaming/
WORKDIR /app/mai_streaming

# Install Python dependencies and the package itself
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install -e .

# Expose ports if needed (e.g., for ingest API)
EXPOSE 8080

# Default command - keep container running
CMD ["tail", "-f", "/dev/null"]
