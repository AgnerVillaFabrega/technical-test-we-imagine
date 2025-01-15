# Usa la imagen oficial de Node.js 22
FROM node:22 AS base

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias primero para aprovechar la caché de Docker
COPY package.json yarn.lock ./

# Instala las dependencias de manera eficiente usando Yarn
RUN yarn install --frozen-lockfile

# Copia el resto de los archivos del proyecto
COPY . .

# Construcción del proyecto
RUN yarn build

# Usa una imagen más ligera para la etapa final
FROM node:22-slim AS production

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias desde la etapa base
COPY --from=base /app/node_modules /app/node_modules

# Copia el código compilado desde la etapa base
COPY --from=base /app/dist /app/dist

# Exponer el puerto que utiliza NestJS
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "dist/main"]