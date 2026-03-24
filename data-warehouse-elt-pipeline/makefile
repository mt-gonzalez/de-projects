DOCKER_COMPOSE_FILE := infrastructure/docker-compose.yaml

ENV_FILE := .env

.DEFAULT_GOAL := help

.PHONY: up
up:
	@echo "Starting project containers..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) up -d
	
.PHONY: down
down:
	@echo "Stopping project containers..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down
	
.PHONY: delete_volumes
delete_volumes: 
	@echo "Stopping containers and deleting volumes..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down -v
	
.PHONY: logs
logs:
	@echo "Showing logs..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) logs -f
	
.PHONY: ps
ps:
	@echo "Listing containers running..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) ps
	
.PHONY: restart
restart: down up
	@echo "Project restarted."

.PHONY: dbt_debug
dbt_debug:
	@echo "Show information on the current dbt environment..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) run --rm dbt debug

.PHONY: dbt_run
dbt_run:
	@echo "Compile SQL and execute against the current target..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) run --rm dbt run

.PHONY: dbt_source_freshness
dbt_source_freshness:
	@echo "Check the current freshness of the project's sources..."
	docker compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) run --rm dbt source freshness
	
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make up       - Start containers"
	@echo "  make down     - Stop containers"
	@echo "  make delete_volumes	Down and volumes deleted"
	@echo "  make restart  - Restart containers"
	@echo "  make logs     - Tail logs"
	@echo "  make ps       - List running containers"
		
	
	
