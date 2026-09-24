FROM eclipse-temurin:17-jre-alpine
RUN apk add --no-cache curl bash wget
WORKDIR /data

# Скачиваем ядро PaperMC
RUN curl -o server.jar https://papermc.io
RUN echo "eula=true" > eula.txt

# Скачиваем туннель playit.gg для обхода портов
RUN curl -Ao playit https://github.com && chmod +x playit

# Скрипт запуска туннеля и самого сервера
RUN echo '#!/bin/bash\n\
./playit & \n\
java -Xms512M -Xmx1G -jar server.jar nogui\n' > start.sh && chmod +x start.sh

CMD ["./start.sh"]
