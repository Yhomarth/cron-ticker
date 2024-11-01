# /app /usr /bin /etc /lib /lib64 /opt /sbin /srv /tmp /usr /var
FROM node:22-alpine3.20

# cd /app
WORKDIR /app

# Dest app
COPY package.json ./

# instalar las dependencias
RUN npm install 

COPY app.js ./

# comando run de la imagen
CMD [ "node", "app.js" ]
