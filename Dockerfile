# Используем готовую сборку Java 17 (подходит для Minecraft 1.20.x+)
FROM eclipse-temurin:17-jre-alpine

# Устанавливаем нужные утилиты: curl для скачивания и bash
RUN apk add --no-cache curl bash wget

# Создаем рабочую папку для сервера
WORKDIR /data

# Скачиваем ядро PaperMC (версия 1.20.4, самая стабильная под плагины)
RUN curl -o server.jar https://papermc.io

# Принимаем лицензионное соглашение EULA Майнкрафта
RUN echo "eula=true" > eula.txt

# Скачиваем и настраиваем агент туннеля playit.gg, чтобы получить бесплатный IP
RUN curl -Ao playit https://github.com && \
    chmod +x playit

# Скрипт одновременного запуска туннеля и сервера Майнкрафт
RUN echo '#!/bin/bash\n\
./playit & \n\
java -Xms1G -Xmx2G -jar server.jar nogui\n' > start.sh && chmod +x start.sh

# Запускаем наш сервер
CMD ["./start.sh"]
