FROM httpd:alpine

LABEL "maintainer"="Pasterskyi A. artypa85@gmail.com"

COPY ./ /usr/local/apache2/htdocs/