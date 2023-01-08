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

clean: down
	rm -Rf ./storage/prometheus/*
	rm -Rf ./storage/alertmanager/*

logs:
	docker compose logs

test:
	curl inet
	curl doc.inet
	curl prom.inet
	curl prom.inet/metrics
