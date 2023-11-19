# syntax=docker/dockerfile:1

FROM node:21-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.25.3-alpine
ENV NODE_ENV production

RUN apt-get update && apt-get upgrade -y

COPY --from=builder /app/* /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
