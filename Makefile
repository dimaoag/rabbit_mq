up: docker-up
init: docker-clear docker-up
down: docker-clear
dev: frontend-dev-build
watch: frontend-watch
install: frontend-install
test: api-test

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

api-test:
	docker-compose run --rm api-php-cli composer test

api-migrations-diff:
	 docker-compose run --rm api-php-cli composer app migrations:diff

api-migrations:
	docker-compose run --rm api-php-cli composer app migrations:migrate -- --no-interaction

api-fixtures:
	docker-compose run --rm api-php-cli composer app fixtures:load
