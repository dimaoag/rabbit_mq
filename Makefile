up: docker-up
init: docker-clear docker-up
down: docker-clear

docker-clear:
	docker-compose down --remove-orphans

docker-up:
	docker-compose up --build -d