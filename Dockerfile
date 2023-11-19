# syntax=docker/dockerfile:1

FROM node:21-alpine3.18 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install

RUN apt-get update && apt-get upgrade -y

COPY . .
RUN npm run build --prod

FROM nginx:1.25.3-alpine
ENV NODE_ENV production
COPY --from=builder /app/* /usr/share/nginx/html/

RUN apt-get update && apt-get upgrade -y

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
