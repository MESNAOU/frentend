# syntax=docker/dockerfile:1

FROM node:21-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod
