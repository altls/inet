.PHONY: conf log src storage

build:
	[ -f ./.env ] || (cp .env.example .env && echo should edit .env first)
	docker compose build

dns:
	cp -f conf/dnsmasq/inet.conf /usr/local/etc/dnsmasq.d/inet.conf
	brew services restart dnsmasq

up: clean
	docker compose up --remove-orphans

upd: clean
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