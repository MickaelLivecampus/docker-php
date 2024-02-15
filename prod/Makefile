build-pull:
	docker pull hexomyns/symfo-groupe3:latest

services-down:
	docker-compose down

services-up:
	docker-compose build
	docker-compose up -d

pull-and-up: build-pull services-down services-up
