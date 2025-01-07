# /app /usr /bin /etc /lib /lib64 /opt /sbin /srv /tmp /usr /var
# FROM --platform=arm64  node:22-alpine3.20
# FROM node:22-alpine3.20
# FROM --platform=$BUILDPLATFORM node:22-alpine3.20
# dependencia de desarrollo
FROM node:22-alpine3.20 AS deps

# cd /app
WORKDIR /app

# Dest app
COPY package.json ./

# instalar las dependencias
RUN npm install 

# test y build
FROM node:22-alpine3.20 AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# realizar testing
RUN npm run test

# dependencias de produccion
FROM node:22-alpine3.20 AS prod

WORKDIR /app

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/src ./src

RUN npm install --omit=dev


# ejecutar en modo produccion
FROM node:22-alpine3.20 AS runner

WORKDIR /app

COPY --from=prod /app/package.json ./package.json
COPY --from=prod /app/node_modules ./node_modules
COPY --from=prod /app/src ./src

CMD [ "node", "src/app.js" ]

# # eliminar las pruebas y archivos no necesarios en PROD 
# RUN rm -rf test/ && rm -rf node_modules/

# # ejecutar en modo produccion

# RUN npm install --prod

# # comando run de la imagen
# CMD [ "node", "src/app.js" ]
