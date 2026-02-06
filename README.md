# apt-cacher-ng
Apt-cacher-ng container to cache apt requests to reduce the bandwidth and speedup the build time

## Description

This repository provides a Docker container running apt-cacher-ng based on the latest Ubuntu image. The image is automatically rebuilt weekly and pushed to Quay.io.

## Usage

### Pulling the Image

```bash
docker pull quay.io/<your-org>/apt-cacher-ng:latest
```

### Running the Container

```bash
docker run -d \
  --name apt-cacher-ng \
  -p 3142:3142 \
  -v apt-cacher-ng-cache:/var/cache/apt-cacher-ng \
  quay.io/<your-org>/apt-cacher-ng:latest
```

### Using the Cache in Your Dockerfiles

Add this line near the beginning of your Dockerfile:

```dockerfile
RUN echo 'Acquire::http::Proxy "http://<apt-cacher-host>:3142";' > /etc/apt/apt.conf.d/01proxy
```

Or on the host system:

```bash
echo 'Acquire::http::Proxy "http://localhost:3142";' | sudo tee /etc/apt/apt.conf.d/01proxy
```

## Configuration

The container uses the default apt-cacher-ng configuration. The cache is stored in `/var/cache/apt-cacher-ng`.

## GitHub Actions

This repository includes automated workflows:

- **Build and Push**: Builds the Docker image on every push to main and weekly (Sundays at 00:00 UTC)
- **Keepalive**: Keeps the repository active to prevent GitHub from disabling scheduled workflows

### Required Secrets

To enable the workflows, configure these secrets in your repository:

- `QUAY_USERNAME`: Your Quay.io username
- `QUAY_PASSWORD`: Your Quay.io password or robot token
- `QUAY_REPOSITORY`: Your Quay.io organization/repository name

## Building Locally

```bash
docker build -t apt-cacher-ng .
docker run -d -p 3142:3142 -v apt-cacher-ng-cache:/var/cache/apt-cacher-ng apt-cacher-ng
```

## License

MIT License - See LICENSE file for details
