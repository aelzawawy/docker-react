# Multi-Step dockerfile build
# todo1> Building the project
from node:16-alpine as builder
workdir /app
COPY package.json ./
RUN npm install -g pnpm@8.0.0
RUN pnpm i
COPY . .
RUN pnpm build

# todo2> Starting Nginx server for production 
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html