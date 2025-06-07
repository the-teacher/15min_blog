# Docker compose commands for Rails application
COMPOSE_FILE := ./docker/docker-compose.yml

# Start containers
start:
	make setup-project-structure
	docker compose -f $(COMPOSE_FILE) up -d

# Start containers
up:
	make start

# Stop containers
stop:
	docker compose -f $(COMPOSE_FILE) down

# Stop containers
down:
	make stop

# Show running containers status
status:
	@echo "Running containers:"
	@docker compose -f $(COMPOSE_FILE) ps --format "table {{.Name}}\t{{.Image}}\t{{.Service}}\t{{.Status}}\t{{.Ports}}"

# Build or rebuild containers
build:
	docker compose -f $(COMPOSE_FILE) build

# Rebuild containers
rebuild:
	docker compose -f $(COMPOSE_FILE) build --no-cache

# Open shell in rails_app container
shell:
	docker compose -f $(COMPOSE_FILE) exec rails_app bash

setup-project-structure:
	touch blog_15min/tmp/.bash_history
