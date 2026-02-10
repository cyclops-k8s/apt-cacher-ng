FROM ubuntu:latest

# Install apt-cacher-ng
RUN apt-get update && \
    apt-get install -y apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the default apt-cacher-ng port
EXPOSE 3142

# Volume for cache persistence
# VOLUME ["/var/cache/apt-cacher-ng"]

# Start apt-cacher-ng in the foreground
RUN ln -s /dev/stdout /var/log/apt-cacher-ng/apt-cacher.log && \
    ln -s /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err && \
    chown apt-cacher-ng:apt-cacher-ng /run/apt-cacher-ng

USER apt-cacher-ng
CMD ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "ForeGround=1", "AllowUserPorts=80 443"]
