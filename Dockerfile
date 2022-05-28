FROM httpd:alpine

LABEL org.opencontainers.image.authors="Pasterskyi A. artypa85@gmail.com" \
      "git"="https://github.com/Artebomba/MyWebSite.git"

COPY ./web_app /usr/local/apache2/htdocs/

HEALTHCHECK --interval=5m --timeout=30s --retries=3  \
  CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-D", "FOREGROUND"]

EXPOSE 80