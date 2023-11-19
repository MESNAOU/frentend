# syntax=docker/dockerfile:1

FROM node as builder
WORKDIR /app
COPY package*.json ./
RUN npm install

RUN apt-get update && apt-get upgrade -y

COPY . .
RUN npm run build --prod

FROM nginx
ENV NODE_ENV production
COPY --from=builder /app/* /usr/share/nginx/html/

RUN apt-get update && apt-get upgrade -y

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
