FROM node:18-alpine3.17 AS build
WORKDIR /nsse-frontend
COPY package*.json ./
RUN npm ci --silent --only=production
COPY . .
RUN npm run build

# Multi Stage Build

FROM nginx:1.25.2-alpine

# copia do container com apelido de build a pasta /nsse-frontend/dist (que é a pasta de build default do vite)
COPY --from=build /nsse-frontend/dist /usr/share/nginx/html
# remove a config default do nginx, para mais info consulte a documentacao do nginx
RUN rm /etc/nginx/conf.d/default.conf
# define o arquivo de configuracao do nginx
COPY nginx/nginx.conf /etc/nginx/conf.d/nginx.conf 
# expoe a porta 80 do container
EXPOSE 80
# desabilita o modo deamon nginx, para facilitar a visao dos logs #
# entrypoint é o comando que mantem o container executando
ENTRYPOINT [ "nginx", "-g", "daemon off;" ] 

# para buildar a imagem utilize:
    # docker build -f src/frontend/Dockerfile -t nsse/frontend:1.0.0 src/frontend

# para executar:
# docker run -p 3000:80 nsse/frontend:1.0.0