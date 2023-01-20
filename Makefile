DOCKER=/snap/bin/docker
DOCKER-COMPOSE=${DOCKER} compose -f srcs/docker-compose.yml

all: up

up:
	${DOCKER-COMPOSE} up -d --build

down:
	${DOCKER-COMPOSE} down

clean: down
	${DOCKER} system prune -a -f

fclean: clean
	${DOCKER} volume rm -f $$(docker volume ls -q)

re: down up

.PHONY: up down clean re

logs:
	${DOCKER-COMPOSE} logs -f