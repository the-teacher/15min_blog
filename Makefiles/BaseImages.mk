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

# Check if images exist locally
# Show image information
check-images:
	@echo "Checking if images exist locally..."
	@docker image inspect $(IMAGE_NAME):arm64 >/dev/null 2>&1 || (echo "Error: Image $(IMAGE_NAME):arm64 not found. Run 'make build-base-arm64' first." && exit 1)
	@docker image inspect $(IMAGE_NAME):amd64 >/dev/null 2>&1 || (echo "Error: Image $(IMAGE_NAME):amd64 not found. Run 'make build-base-amd64' first." && exit 1)
	@echo "All required images exist."
	@echo "Image $(IMAGE_NAME):arm64:"
	@docker image inspect $(IMAGE_NAME):arm64 | grep -E '"Id":|"RepoTags":'
	@echo "Image $(IMAGE_NAME):amd64:"
	@docker image inspect $(IMAGE_NAME):amd64 | grep -E '"Id":|"RepoTags":'

# Show image sizes
image-sizes:
	@echo "Checking image sizes..."
	@echo "=============================================================="
	@docker images --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}" | grep -E "$(IMAGE_NAME):(arm64|amd64)"
	@echo "=============================================================="

# Create manifest (local only)
create-base-manifest:
	make check-images
	docker manifest create \
		$(IMAGE_NAME):latest \
		--amend $(IMAGE_NAME):arm64 \
		--amend $(IMAGE_NAME):amd64

# Push images to Docker Hub
push-base-images:
	docker push $(IMAGE_NAME):arm64
	docker push $(IMAGE_NAME):amd64

# Push manifest to Docker Hub
push-base-manifest:
	make push-base-images
	docker manifest push --purge $(IMAGE_NAME):latest

# Complete workflow: build, push images, create manifest, and push manifest
update-base-images:
	make build-base-all
	make push-base-images
	make create-base-manifest
	make push-base-manifest
	@echo "All images built and pushed successfully!"

# Enter shell of the latest ARM64 image as rails user
shell-base-arm64:
	docker run --rm -it \
		--platform linux/arm64 \
		$(IMAGE_NAME):arm64 \
		/bin/bash

# Enter shell of the latest AMD64 image as rails user
shell-base-amd64:
	docker run --rm -it \
		--platform linux/amd64 \
		$(IMAGE_NAME):amd64 \
		/bin/bash

# Enter shell of the latest ARM64 image as root user
shell-base-arm64-root:
	docker run --rm -it \
		--platform linux/arm64 \
		-v $(PWD)/docker/test/image_processors.sh:/root/image_processors.sh \
		--user root \
		$(IMAGE_NAME):arm64 \
		/bin/bash

# Enter shell of the latest AMD64 image as root user
shell-base-amd64-root:
	docker run --rm -it \
		--platform linux/amd64 \
		-v $(PWD)/docker/test/image_processors.sh:/root/image_processors.sh \
		--user root \
		$(IMAGE_NAME):amd64 \
		/bin/bash

# Clean all docker images related to this project
clean-base-images:
	@echo "Cleaning all base images..."
	@echo "Removing tagged images..."
	-docker rmi $(IMAGE_NAME):arm64 $(IMAGE_NAME):amd64 $(IMAGE_NAME):latest
	@echo "Removing all dangling images (intermediate build layers)..."
	-docker image prune -af
	@echo "Base images cleanup completed!"

# Show all docker images
show-all-images:
	@echo "All Docker images:"
	@echo "=============================================================="
	@docker images
	@echo "=============================================================="

# Help for base image building commands
help-base-image:
	@echo "=============================================================="
	@echo "Base image building commands:"
	@echo "=============================================================="
	@echo "  make build-base-arm64        - Build base image for ARM64"
	@echo "  make build-base-amd64        - Build base image for AMD64"
	@echo "  make build-base-all          - Build base image for all platforms"
	@echo "  make create-base-manifest    - Create manifest for base image"
	@echo "  make push-base-images        - Push base images to Docker Hub"
	@echo "  make push-base-manifest      - Push manifest to Docker Hub"
	@echo "  make update-base-images      - Build, push images and manifest"
	@echo "  make shell-base-arm64        - Enter shell of base ARM64 image as rails user"
	@echo "  make shell-base-amd64        - Enter shell of base AMD64 image as rails user"
	@echo "  make shell-base-arm64-root   - Enter shell of base ARM64 image as root user"
	@echo "  make shell-base-amd64-root   - Enter shell of base AMD64 image as root user"
	@echo "  make clean-base-images       - Remove all base project images"
	@echo "=============================================================="