.PHONY: conf log src

build:
	[ -f ./.env ] || (cp .env.example .env && echo should edit .env first)
	docker compose build

up: down
	docker compose up --remove-orphans

upd: down
	docker compose up -d --remove-orphans

exec:
	docker compose exec -it npa /bin/sh

down:
	docker compose down

logs:
	docker compose logs
