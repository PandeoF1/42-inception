all: 
	@mkdir -p /home/pandeo/data
	@mkdir -p /home/pandeo/data/wordpress
	@mkdir -p /home/pandeo/data/mariadb
	@echo "127.0.0.1 tnard.42.fr" >> /etc/hosts
	@docker-compose -f ./srcs/docker-compose.yml up -d mariadb
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

mysql:
	@docker-compose -f srcs/docker-compose.yml exec mariadb mariadb -u tnard -p

wordpress:
	@docker-compose -f srcs/docker-compose.yml exec wordpress bash

nginx:
	@docker-compose -f srcs/docker-compose.yml exec nginx bash

clean:
	@docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q); \
	rm -rf /home/pandeo/data/wordpress; \
	rm -rf /home/pandeo/data/mariadb; \

.PHONY: all re down clean mysql