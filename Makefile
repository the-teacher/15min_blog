include Makefiles/BuildImages.Makefile

help:
	@echo "Available commands:"
	@echo "  make build-base-arm64     - Build base image for ARM64"
	@echo "  make build-base-amd64     - Build base image for AMD64"
	@echo "  make build-base-all       - Build base image for all platforms"
	@echo "  make create-base-manifest - Create manifest for base image"
	@echo "  make push-base-all        - Push base image to Docker Hub"
