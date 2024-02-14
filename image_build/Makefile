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

tag-images:
	docker tag php-php hexomyns/symfo-groupe3:latest

push-images:
	docker push hexomyns/symfo-groupe3:latest

clone-src-repository:
	git clone ${1} php_service/src

build-and-push: update-src-repository build-images tag-images push-images