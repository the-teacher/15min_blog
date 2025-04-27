# Variables for building images
DOCKERFILE = docker/_Base.Dockerfile
IMAGE_NAME = iamteacher/blog_15min.base

# Ruby version and OS version for the base image
RUBY_VERSION = 3.4.3-bookworm

# Build image for ARM64
build-base-arm64:
	docker build \
		-t $(IMAGE_NAME):arm64 \
		-f $(DOCKERFILE) \
		--build-arg BUILDPLATFORM="linux/arm64" \
		--build-arg TARGETARCH="arm64" \
		--build-arg RUBY_VERSION="$(RUBY_VERSION)" \
		.

# Build image for AMD64
build-base-amd64:
	docker build \
		-t $(IMAGE_NAME):amd64 \
		-f $(DOCKERFILE) \
		--build-arg BUILDPLATFORM="linux/amd64" \
		--build-arg TARGETARCH="amd64" \
		--build-arg RUBY_VERSION="$(RUBY_VERSION)" \
		.

# Build images for all platforms
build-base-all:
	make build-base-arm64
	make build-base-amd64

# Create manifest
create-base-manifest:
	docker manifest create \
		$(IMAGE_NAME):latest \
		--amend $(IMAGE_NAME):arm64 \
		--amend $(IMAGE_NAME):amd64

# Push images to Docker Hub
push-base-all:
	docker push $(IMAGE_NAME):arm64
	docker push $(IMAGE_NAME):amd64
	docker manifest push --purge $(IMAGE_NAME):latest
