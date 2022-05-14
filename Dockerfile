FROM httpd:alpine

LABEL org.opencontainers.image.authors="Pasterskyi A. artypa85@gmail.com" \
      "git"="https://github.com/Artebomba/MyWebSite.git"

COPY . /usr/local/apache2/htdocs/

HEALTHCHECK --interval=5m --timeout=10s --retries=3 --start_period=1m \
  CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-D", "FOREGROUND"]

EXPOSE 80