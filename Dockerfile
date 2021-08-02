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
# copy something from the previous stage named builder to the following directory
COPY --from=builder /app/build /usr/share/nginx/html