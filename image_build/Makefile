# https://how.wtf/write-a-multi-line-command-in-a-makefile.html

ifndef BUILD_TAG
	BUILD_TAG:=$(shell date +'%Y-%m-%d-%H-%M-%S')-$(shell git rev-parse --short HEAD)
endif

echo-build-tag:
	echo $(BUILD_TAG)

update-src-repository:
	cd php_service/src && git pull origin master

start:
	docker compose up -d

stop:
	docker compose kill

build-images:
	docker compose build php 

# image_build-php is based: 
# 1 - parent folder name of docker-compose (image_build)
# 2 - service name (php in docker-compose.yml)
tag-images:
	docker tag image_build-php hexomyns/symfo-groupe3:latest

push-images:
	docker push hexomyns/symfo-groupe3:latest

clone-src-repository:
	git clone ${1} php_service/src

build-and-push: update-src-repository build-images tag-images push-images
build-and-push-from-ci: build-images tag-images push-images