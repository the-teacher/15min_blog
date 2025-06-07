# Docker compose commands for Rails application
COMPOSE_FILE := ./docker/docker-compose.yml

# Install dependencies
rails-bundle:
	docker compose -f $(COMPOSE_FILE) exec rails_app bash -c "bundle install"

# Create database
rails-db-create:
	docker compose -f $(COMPOSE_FILE) exec rails_app bash -c "bundle exec rails db:create"

# Migrate database
rails-db-migrate:
	docker compose -f $(COMPOSE_FILE) exec rails_app bash -c "bundle exec rails db:migrate"

# Seed database
rails-db-seed:
	docker compose -f $(COMPOSE_FILE) exec rails_app bash -c "bundle exec rails db:seed"

# Start containers
rails-start:
	make rails-bundle
	make rails-db-create
	make rails-db-migrate
	docker compose -f $(COMPOSE_FILE) exec rails_app bash -c "bundle exec rails s -b 0.0.0.0 -p 3000"

