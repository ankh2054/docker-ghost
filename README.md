![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

 Blog-docker

Ghost-docker sets up a container running Ghost Blogging platform,   based on variables provided. It will automatically start Ghost using the ENV variables provided. 


### Ghost-DOCKER Usage


Firstly you need to create the necessary folders on your docker host. The container will expose directories created below directly into the container to ensure our WWW, and LOG folders are persistent.
This ensures that even if your container is lost or deleted, you won't loose your MODX database or website files.

	$ mkdir -p /data/sites/www.test.co.uk/www
	$ mkdir -p /data/sites/www.test.co.uk/logs



To build the docker image from Git:

`docker build https://github.com/ankh2054/docker-ghost.git -t ghost`

To run it:

  ```
docker run  --name docker.ghost --expose 80 \
 -d -e 'VIRTUAL_HOST=www.test.co.uk' \
 -e 'DB_NAME=ghost'
 -e 'DB_USER=ghost'
 -e 'DB_PASS=ghost'
 -e 'ROOT_PWD=securepassword'
 -v /data/sites/www.test.co.uk/mysql:/var/lib/mysql \
 -v /data/sites/www.test.co.uk:/DATA ghost

 ```

This will create a new DJANGO APP with the following values:

	$ Virtual Host: - www.test.co.uk
	$ Mysql DB: ghost
	$ Mysql user to access django DB: ghost
	$ Mysql password for user: ghost
	$ Mysql root password: securepassword
	


# NGINX-PROXY




nginx-proxy sets up a container running nginx and [docker-gen][1].  docker-gen generates reverse proxy configs for nginx and reloads nginx when containers are started and stopped.

See [Automated Nginx Reverse Proxy for Docker][2] for why you might want to use this.

### Nginx-proxy Usage

To run it:

    $ docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro etopian/nginx-proxy




[1]: https://github.com/etopian/docker-gen
[2]: http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/
