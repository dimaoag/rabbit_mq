up: docker-up
init: docker-clear docker-up
down: docker-clear
dev: frontend-dev-build
watch: frontend-watch
install: frontend-install

docker-clear:
	docker-compose down --remove-orphans

docker-up:
	docker-compose up --build -d

frontend-dev-build:
	docker-compose run --rm frontend-nodejs npm run dev

frontend-watch:
	docker-compose run --rm frontend-nodejs npm run watch

frontend-install:
	docker-compose run --rm frontend-nodejs npm install

composer-install:
	docker-compose run --rm api-php-cli composer install

composer-update:
	docker-compose run --rm api-php-cli composer update
