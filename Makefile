up: docker-up
init: 	docker-clear docker-up \
 		api-permissions api-env composer-install api-genrsa pause api-migrations api-fixtures \
 		frontend-env frontend-install frontend-build storage-permissions \
 		websocket-env websocket-key websocket-install websocket-start

build: docker-clear docker-up
down: docker-clear
dev: frontend-dev-build
watch: frontend-watch
install: frontend-install
test: api-test

docker-clear:
	docker-compose down --remove-orphans

docker-up:
	docker-compose up --build -d

pause:
	sleep 5

###############################################################################################

api-permissions:
	sudo chmod 777 api/var
	sudo chmod 777 api/var/cache
	sudo chmod 777 api/var/log
	sudo chmod 777 api/var/mail
	sudo chmod 777 storage/public/video

api-env:
	docker-compose exec api-php-cli rm -f .env
	docker-compose exec api-php-cli ln -sr .env.example .env

api-genrsa:
	docker-compose exec api-php-cli openssl genrsa -out private.key 2048
	docker-compose exec api-php-cli openssl rsa -in private.key -pubout -out public.key

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


####################################################################################################

frontend-env:
	docker-compose exec frontend-nodejs rm -f .env.local
	docker-compose exec frontend-nodejs ln -sr .env.local.example .env.local

frontend-build:
	docker-compose exec frontend-nodejs npm run build

frontend-dev-build:
	docker-compose run --rm frontend-nodejs npm run dev

frontend-watch:
	docker-compose run --rm frontend-nodejs npm run watch

frontend-install:
	docker-compose run --rm frontend-nodejs npm install

storage-permissions:
	sudo chmod 777 storage/public/video


#################################################################################################

websocket-env:
	docker-compose exec websocket-nodejs rm -f .env
	docker-compose exec websocket-nodejs ln -sr .env.example .env

websocket-key:
	rm -f ./websocket/public.key
	cp ./api/public.key ./websocket/public.key

websocket-install:
	docker-compose exec websocket-nodejs npm install

websocket-start:
	docker-compose exec websocket-nodejs npm run start
