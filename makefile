.PHONY: conf log src

build:
	docker compose build

up: down
	docker compose up --remove-orphans

upd: down
	docker compose up -d --remove-orphans

exec:
	docker compose exec -it inet-npna-1 /bin/sh

down:
	docker compose down

logs:
	docker compose logs
