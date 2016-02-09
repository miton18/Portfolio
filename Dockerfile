FROM node:onbuild

MAINTAINER miton18@github.com

ENV NODE_ENV production

RUN npm install -g supervisor

# Expose the ports that your app uses :
EXPOSE 80

