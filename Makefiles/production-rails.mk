# Production Rails commands for Docker deployment
COMPOSE_FILE := ./docker/docker-compose.yml
PRODUCTION_COMPOSE_FILE := ./docker/docker-compose.production.yml

# Install production dependencies
production-rails-bundle:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle install --without development test"

# Precompile assets for production
production-rails-assets:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails assets:precompile"

# Create production database
production-rails-db-create:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails db:create"

# Migrate production database
production-rails-db-migrate:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails db:migrate"

# Seed production database
production-rails-db-seed:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails db:seed"

# Setup production database (create + migrate + seed)
production-rails-db-setup:
	make production-rails-db-create
	make production-rails-db-migrate
	make production-rails-db-seed

# Start Rails server in production mode
production-rails-server:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails s -e production -b 0.0.0.0 -p 3000"

# Full production startup sequence
production-rails-start:
	make production-rails-bundle
	make production-rails-assets
	make production-rails-db-setup
	make production-rails-server

# Start production containers in detached mode
production-rails-up:
	docker compose -f $(COMPOSE_FILE) up -d

# Stop production containers
production-rails-down:
	docker compose -f $(COMPOSE_FILE) down

# Restart production containers
production-rails-restart:
	make production-rails-down
	make production-rails-up

# View production logs
production-rails-logs:
	docker compose -f $(COMPOSE_FILE) logs -f rails_app

# Clean production assets
production-rails-clean:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails assets:clobber"

# Production console
production-rails-console:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash -c "bundle exec rails c"

# Production bash access
production-rails-bash:
	docker compose -f $(COMPOSE_FILE) exec -e RAILS_ENV=production rails_app bash
