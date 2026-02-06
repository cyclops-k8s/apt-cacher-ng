FROM ubuntu:latest

# Install apt-cacher-ng
RUN apt-get update && \
    apt-get install -y apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the default apt-cacher-ng port
EXPOSE 3142

# Create cache directory
RUN mkdir -p /var/cache/apt-cacher-ng

# Volume for cache persistence
VOLUME ["/var/cache/apt-cacher-ng"]

# Start apt-cacher-ng in the foreground
CMD ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "ForeGround=1"]
