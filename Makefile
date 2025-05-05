include Makefiles/BuildImages.Makefile

# Main help command
help:
	@echo "15min_blog - Available commands:"
	@echo "=============================================================="
	@echo "Image building and management:"
	@echo "  make help-image-build     - Show base image building commands"
	@echo "  make help-main-image      - Show main image building commands"
	@echo "=============================================================="
	@echo "More categories will be added in the future"
	@echo "=============================================================="

# Help for image building commands
help-image-build:
	@echo "=============================================================="
	@echo "Image building commands:"
	@echo "=============================================================="
	@echo "  make build-base-arm64     - Build base image for ARM64"
	@echo "  make build-base-amd64     - Build base image for AMD64"
	@echo "  make build-base-all       - Build base image for all platforms"
	@echo "  make check-images         - Check if images exist locally"
	@echo "  make image-sizes          - Show sizes of all built images"
	@echo "  make create-base-manifest - Create manifest for base image"
	@echo "  make push-base-images     - Push base images to Docker Hub"
	@echo "  make push-base-manifest   - Push manifest to Docker Hub"
	@echo "  make update-base-images   - Build, push images and manifest"
	@echo "  make shell-arm64          - Enter shell of ARM64 image as rails user"
	@echo "  make shell-amd64          - Enter shell of AMD64 image as rails user"
	@echo "  make shell-arm64-root     - Enter shell of ARM64 image as root user"
	@echo "  make shell-amd64-root     - Enter shell of AMD64 image as root user"
	@echo "  make clean-images         - Remove all project images and layers"
	@echo "  make show-all-images      - Show all Docker images"
	@echo "=============================================================="

# Help for main image building commands
help-main-image:
	@echo "=============================================================="
	@echo "Main image building commands:"
	@echo "=============================================================="
	@echo "  make build-main-arm64     - Build main image for ARM64"
	@echo "  make build-main-amd64     - Build main image for AMD64"
	@echo "  make build-main-all       - Build main image for all platforms"
	@echo "  make create-main-manifest - Create manifest for main image"
	@echo "  make push-main-images     - Push main images to Docker Hub"
	@echo "  make push-main-manifest   - Push manifest to Docker Hub"
	@echo "  make update-main-images   - Build, push images and manifest"
	@echo "  make shell-main-arm64     - Enter shell of main ARM64 image"
	@echo "  make shell-main-amd64     - Enter shell of main AMD64 image"
	@echo "  make run-rails-app-arm64  - Run Rails app in ARM64 container"
	@echo "  make run-rails-app-amd64  - Run Rails app in AMD64 container"
	@echo "  make clean-main-images    - Remove all main project images"
	@echo "=============================================================="
