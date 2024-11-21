# /app /usr /bin /etc /lib /lib64 /opt /sbin /srv /tmp /usr /var
FROM node:22-alpine3.20

# cd /app
WORKDIR /app

# Dest app
COPY package.json ./

# instalar las dependencias
RUN npm install 

COPY . .

# realizar testing
RUN npm run test

# eliminar las pruebas y archivos no necesarios en PROD 
RUN rm -rf test/ && rm -rf node_modules/

# ejecutar en modo produccion

RUN npm install --prod

# comando run de la imagen
CMD [ "node", "src/app.js" ]
