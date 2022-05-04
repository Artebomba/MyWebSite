FROM alpine

LABEL "maintainer"="Pasterskyi A. artypa85@gmail.com"

# Upgrade existing packages in the base image
# Install apache from packages with out caching install files
RUN apk --no-cache upgrade && apk add --no-cache apache2

# Creat directory for apache2 to store PID file
RUN mkdir /run/apache2

# Copy an original application
COPY ./* /var/www/html/

# Open port for httpd access
EXPOSE 80

# Run httpd in foreground so that the container does not quit
# soon after start
CMD ["httpd", "-D","FOREGROUND"]

# Srart httpd when container runs
ENTRYPOINT ["/usr/sbin/httpd"]