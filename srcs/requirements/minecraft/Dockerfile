FROM debian:buster

RUN apt update && apt install -y wget default-jre

RUN mkdir -p /root/minecraft && cd /root/minecraft && wget https://launcher.mojang.com/v1/objects/952438ac4e01b4d115c5fc38f891710c4941df29/server.jar && echo "eula=true" > /root/minecraft/eula.txt && java --version

WORKDIR /root/minecraft

EXPOSE 25565

CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar"]
