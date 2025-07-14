#  NestJS + MongoDB - Dockerized App

Este entorno permite levantar una aplicación NestJS con MongoDB usando Docker y Docker Compose.
```
                                    +-----------------------+
                                    |   Navegador/Cliente   |
                                    +-----------------------+
                                                |
                                                v
                                    +-----------------------+
                                    |   Aplicación NestJS   |
                                    |     (Puerto 3000)     |
                                    +-----------------------+
                                                |
                                                v
                                    +-----------------------+
                                    |       MongoDB         |
                                    |    (Puerto 27017)     |
                                    +-----------------------+
```

[Nestjs-deploy](https://docs.nestjs.com/deployment)

##  Requisitos

- Docker
- Docker Compose

## Cómo usar

1. Clonar el siguiente repositorio y cambia al directorio de trabajo

```
git clone https://github.com/yosoyfunes/app-template-nestjs
```
```
cd app-template-nestjs
```

2. Crear archivo Dockerfile

```
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

# Instala las dependencias para la conexiÃ³n con MongoDB
RUN npm i @nestjs/mongoose mongoose

# Copia el resto del código fuente
COPY . .

# Compila la aplicación (TypeScript a JavaScript)
RUN npm run build

#Expone el puerto 3000 (usado por defecto en apps NestJS)
EXPOSE 3000

# Comando para ejecutar la app en modo DESA
CMD ["npm", "run", "start:prod"]
```
3. Crea un archivo Docker Compose con extensión yaml

```
services:
  app:
    build:
      context: .
      target: desa
    volumes:
      - .:/usr/src/app
      - /usr/src/app/node_modules
    ports:
      - '3000:3000'
    environment:
      - MONGO_URI=mongodb://mongo:27017/nest
    depends_on:
      - mongo
    profiles:
      - dev

  app-prod:
    build:
      context: .
      target: prod
    ports:
      - '3000:3000'
    environment:
      - MONGO_URI=mongodb://mongo:27017/nest
    depends_on:
      - mongo
    profiles:
      - prod

  mongo:
    image: mongo:6.0
    restart: always
    ports:
      - '27017:27017'
    volumes:
      - mongo_data:/data/db

volumes:
  mongo_data:
```

4. Configura Nestjs para la comunicación con MongoDB

En nuestro archivo app.module.ts incluiremos las siguientes líneas

```
import { MongooseModule } from '@nestjs/mongoose';
```
```
(process.env.MONGO_URI)
```
Quedando de la siguiente manera

```
import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [MongooseModule.forRoot(process.env.MONGO_URI)],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
```

[nestjs-mongodb](https://docs.nestjs.com/techniques/mongodb)

5. Levantar entorno dev

```
docker compose --profile dev up --build
```

<img width="1347" height="418" alt="image" src="https://github.com/user-attachments/assets/1f5bec56-51cf-49ed-adc2-46f839ebbba3" />
<img width="1339" height="93" alt="image" src="https://github.com/user-attachments/assets/27d89d07-2d4c-4f53-b9d8-a23fb8ad71d1" />
<img width="1145" height="310" alt="image" src="https://github.com/user-attachments/assets/9e7365c5-2fae-45a3-9548-a9888822422f" />
<img width="1103" height="205" alt="image" src="https://github.com/user-attachments/assets/1676dad6-3d0d-4714-b89f-5696c507d0bf" />
<img width="1345" height="410" alt="image" src="https://github.com/user-attachments/assets/0d51a37a-3605-4a9a-9b9f-ae89b20b81ac" />


6. Levantar entorno prod

```
docker compose --profile prod up --build
```

<img width="1371" height="417" alt="image" src="https://github.com/user-attachments/assets/e6d470a5-aba2-4d84-bfde-0c5757cc6a65" />
<img width="1415" height="381" alt="image" src="https://github.com/user-attachments/assets/6d6de4cf-97fa-48dc-b298-f1214fffa3f3" />
<img width="1417" height="419" alt="image" src="https://github.com/user-attachments/assets/e4cc5829-b7f7-471e-9be8-8823efd88066" />


