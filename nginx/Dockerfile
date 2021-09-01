#FROM ubuntu:trusty 
FORM nginx:stable
RUN apt-get update 
RUN apt-get -y install 
RUN apt-get -y install mysql-client
RUN apt-get -y install nginx 
COPY ["loop.sh", "/"]
CMD ["/loop.sh"]
