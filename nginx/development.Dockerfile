FROM nginx:stable
RUN apt-get update 
RUN apt-get -y install vim
CMD [tail-f /dev/null]
