include Makefiles/BaseImages.Makefile
include Makefiles/MainImages.Makefile

# Main help command
help:
	@echo "15min_blog - Available commands:"
	@echo "=============================================================="
	@echo "Image building and management:"
	@echo "  make help-image-build     - Show general image building commands"
	@echo "  make help-base-image      - Show base image building commands"
	@echo "  make help-main-image      - Show main image building commands"
	@echo "=============================================================="
	@echo "More categories will be added in the future"
	@echo "=============================================================="

# Help for general image building commands
help-image-build:
	@echo "=============================================================="
	@echo "General image building commands:"
	@echo "=============================================================="
	@echo "  make check-images         - Check if images exist locally"
	@echo "  make image-sizes          - Show sizes of all built images"
	@echo "  make show-all-images      - Show all Docker images"
	@echo "  make clean-all-images     - Remove all project images (base and main)"
	@echo "=============================================================="


# Clean all images (base and main)
clean-all-images:
	@echo "Cleaning all project images (base and main)..."
	make clean-base-images
	make clean-main-images
	@echo "All images cleanup completed!"
