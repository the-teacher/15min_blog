include Makefiles/BuildImages.Makefile

help:
	@echo "Available commands:"
	@echo "  make build-base-arm64     - Build base image for ARM64"
	@echo "  make build-base-amd64     - Build base image for AMD64"
	@echo "  make build-base-all       - Build base image for all platforms"
	@echo "  make check-images         - Check if images exist locally"
	@echo "  make create-base-manifest - Create manifest for base image"
	@echo "  make push-base-images     - Push base images to Docker Hub"
	@echo "  make push-base-manifest   - Push manifest to Docker Hub"
	@echo "  make update-base-images   - Build, push images and manifest"
	@echo "  make shell-arm64          - Enter shell of ARM64 image"
	@echo "  make shell-amd64          - Enter shell of AMD64 image"
