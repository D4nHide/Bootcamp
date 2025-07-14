# Etapa base
FROM node:18-alpine AS base
WORKDIR /usr/src/app
COPY package*.json ./

# Etapa para desarrollo
FROM base AS desa
# Instala las dependencias del proyecto
RUN npm install
# Instala las dependencias para la conexión con MongoDB
RUN npm i @nestjs/mongoose mongoose
# Copia el resto del código fuente
COPY . .
# Comando para ejecutar la app en modo DESA
CMD ["npm", "run", "start:dev"]

# Etapa para producción
FROM base AS prod
# Ignora las dependencias de desarrollo
RUN npm ci --only=production
# Instala las dependencias para la conexión con MongoDB
RUN npm i @nestjs/mongoose mongoose
# Copia el resto del código fuente
COPY . .
# Compila la aplicación (TypeScript a JavaScript)
RUN npm run build
#Expone el puerto 3000 (usado por defecto en apps NestJS)
EXPOSE 3000
# Comando para ejecutar la app en modo DESA
CMD ["npm", "run", "start:prod"]
