include Makefiles/BaseImages.mk
include Makefiles/MainImages.mk
include Makefiles/Project.mk
include Makefiles/Rails.mk

# Main help command
help:
	@echo "15min_blog - Available commands:"
	@echo "=============================================================="
	@echo "Project management:"
	@echo "  make start               - Start all containers"
	@echo "  make stop                - Stop all containers"
	@echo "  make status              - Show running containers status"
	@echo "  make build               - Build or rebuild containers"
	@echo "  make rebuild             - Rebuild containers"
	@echo "  make shell               - Open shell in rails_app container"
	@echo "=============================================================="
	@echo "Rails commands:"
	@echo "  make rails-start         - Start Rails server with all dependencies"
	@echo "  make rails-bundle        - Install Ruby dependencies"
	@echo "  make rails-db-create     - Create database"
	@echo "  make rails-db-migrate    - Run database migrations"
	@echo "  make rails-db-seed       - Seed the database"
	@echo "=============================================================="
	@echo "Docker images (see 'make help-image-build' for more):"
	@echo "  make help-base-image     - Show base image building commands"
	@echo "  make help-main-image     - Show main image building commands"
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
