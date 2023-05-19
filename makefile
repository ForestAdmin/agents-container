.DEFAULT_GOAL := help

agent-nodejs-postgres: ## run agent-nodejs with a postgres database
	./setup-db.sh postgres && docker compose --project-directory . -f databases/postgres/docker-compose.yml -f databases/setup/docker-compose.yml -f agents/agent-nodejs/docker-compose.yml up --build --force-recreate

agent-nodejs-mysql: ## run agent-nodejs with a mysql database
	./setup-db.sh mysql && docker compose --project-directory . -f databases/mysql/docker-compose.yml -f databases/setup/docker-compose.yml -f agents/agent-nodejs/docker-compose.yml  up --build --force-recreate
down: ## down all the containers
	docker compose --project-directory . -f databases/postgres/docker-compose.yml down -v
	docker compose --project-directory . -f databases/mysql/docker-compose.yml down -v
	docker compose --project-directory . -f databases/setup/docker-compose.yml down -v
	docker compose --project-directory . -f agents/agent-nodejs/docker-compose.yml down -v

.PHONY: help
help: ## display all the commands with description
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
