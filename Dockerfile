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
# This is for travis and elasticbeanstalk during deployment, for our local machines this instructions means nothing really but when
# AWS ElasticBeanStalk sees this instruction it immediately know that is has to map to that port
EXPOSE 80
# copy something from the previous stage named builder to the following directory
COPY --from=builder /app/build /usr/share/nginx/html