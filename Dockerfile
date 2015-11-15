FROM node:onbuild

RUN npm install -g supervisor

# Expose the ports that your app uses. For example:
EXPOSE 80

#sudo docker build -t portfolio .
#sudo docker run --restart=always --name=portfolio-instance -p 8082:80 -it portfolio

