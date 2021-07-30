# Implemennting multi-stage build process
# 1) Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <---- 'build' is going to be created in the working directory and it is the resulting folder that has the stuff that
#                   we want to serve to the outside world

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html