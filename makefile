.DEFAULT_GOAL := help

agent-nodejs-postgres: ## run agent-nodejs with a postgres database
	./setup-db.sh postgres && docker compose --project-directory . -f agents/agent-nodejs/docker-compose.yml -f databases/postgres/docker-compose.yml up

agent-nodejs-mysql: ## run agent-nodejs with a mysql database
	./setup-db.sh mysql && docker compose --project-directory . -f agents/agent-nodejs/docker-compose.yml -f databases/mysql/docker-compose.yml up

stop: ## stop all the containers
	docker compose --project-directory . -f agents/agent-nodejs/docker-compose.yml -f databases/postgres/docker-compose.yml rm --force --stop
	docker compose --project-directory . -f agents/agent-nodejs/docker-compose.yml -f databases/mysql/docker-compose.yml rm --force --stop

.PHONY: help
help: ## display all the commands with description
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
