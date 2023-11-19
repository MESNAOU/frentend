# syntax=docker/dockerfile:1

FROM node:21-alpine3.17 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:alpine3.18-slim
ENV NODE_ENV production

RUN apk --no-cache upgrade && \
    apk --no-cache add libx11@1.8.7-r0 openssl/libcrypto3@3.1.4-r1

COPY --from=builder /app/* /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
