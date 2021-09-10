FROM nginx:stable
RUN apt-get update 
RUN apt-get -y install vim
COPY ["loop.sh", "/"]
CMD ["/loop.sh"]
#CMD [tail-f /dev/null]
