FROM alpine:3.6

ENV ALPINE_VERSION=3.6

# Install needed packages. Notes:
#   * nodejs: Node.js and NPM 
#   * nginx: Nginx
#   * Git: Git to store wiki-js documents
#   * Curl: Curl for downloads.
#   * nodejs-npm: Required for Wikijs install
#   * bash: Required for Wikijs install
#   * supervisor: Control starting of applications
#   * Mysql: Mysql server
#   * mysql-client: Required for automatic install of Mysql and creation of DB.
#   * mariadb-dev: Required for automatic install of Mysql and creation of DB.
#   * sudo: Required for Ghost-install.



ENV PACKAGES="\
  nodejs \
  nginx \
  git \
  curl \
  unzip \
  nodejs-npm \
  bash \
  supervisor \
  mysql \
  mysql-client\
  mariadb-dev \
  sudo \
"

RUN apk --update add --no-cache $PACKAGES  \
    && echo 


EXPOSE 80
ENV NODE_ENV production

# Add files
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/supervisord.conf /etc/supervisord.conf
ADD files/my.cnf /etc/mysql/my.cnf
ADD files/prism.js /tmp/prism.js
ADD files/prism.css /tmp/prism.css
ADD files/prism.js.conf /tmp/prism.js.conf
ADD files/prism.css.conf /tmp/prism.css.conf
ADD start.sh /

# Entrypoint
RUN chmod u+x /start.sh
CMD /start.sh
