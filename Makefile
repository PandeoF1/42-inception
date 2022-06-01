all: 
	@mkdir -p /home/pandeo/data
	@mkdir -p /home/pandeo/data/wordpress
	@mkdir -p /home/pandeo/data/mariadb
	@mkdir -p /home/pandeo/data/minecraft
	@sed -i "/127.0.0.1 tnard.42.fr/d" /etc/hosts
	@sed -i "/127.0.0.1 tnard-adminer.42.fr/d" /etc/hosts
	@sed -i "/127.0.0.1 tnard-perso.42.fr/d" /etc/hosts
	@echo "127.0.0.1 tnard.42.fr" >> /etc/hosts
	@echo "127.0.0.1 tnard-adminer.42.fr" >> /etc/hosts
	@echo "127.0.0.1 tnard-perso.42.fr" >> /etc/hosts
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

kill:
	@docker-compose -f ./srcs/docker-compose.yml kill

re:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

top:
	@docker-compose -f ./srcs/docker-compose.yml top

mysql:
	@docker-compose -f ./srcs/docker-compose.yml exec mariadb mariadb -u tnard -p

wordpress:
	@docker-compose -f ./srcs/docker-compose.yml exec wordpress bash

ftp:
	@docker-compose -f ./srcs/docker-compose.yml exec ftp bash

nginx:
	@docker-compose -f ./srcs/docker-compose.yml exec nginx bash

minecraft:
	@docker-compose -f ./srcs/docker-compose.yml exec minecraft screen -x

ps:
	@docker-compose -f ./srcs/docker-compose.yml ps

logs:
	@docker-compose -f ./srcs/docker-compose.yml logs

clean:
	@docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q); \
	rm -rf /home/pandeo/data/wordpress; \
	rm -rf /home/pandeo/data/minecraft; \
	rm -rf /home/pandeo/data/mariadb

.PHONY: all re down clean mysql nginx wordpress