FROM httpd:alpine

LABEL "maintainer"="Pasterskyi A. artypa85@gmail.com"

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

COPY ./ /usr/local/apache2/htdocs/