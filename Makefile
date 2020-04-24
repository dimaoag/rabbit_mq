up: docker-up
init: docker-clear docker-up

docker-clear:
	docker-compose down --remove-orphans

docker-up:
	docker-compose up --build -d