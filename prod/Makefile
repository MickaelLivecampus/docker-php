build-pull:
	docker-compose pull hexomyns/symfo-groupe3:latest

services-down:
	docker-compose down

volume-remove:
	docker-compose build volume rm prod_php_volume

services-up:
	docker-compose build
	docker-compose up -d

pull-and-up: build-pull services-down volume-remove services-up
