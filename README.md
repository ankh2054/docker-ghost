# docker-ghost


```
docker run  --name docker.ghost --expose 80 \
 -d -e 'VIRTUAL_HOST=www.test.co.uk' \
 -e 'DB_NAME=ghost'
 -e 'DB_USER=ghost'
 -e 'DB_PASS=ghost'
 -e 'ROOT_PWD=securepassword'
 -v /data/sites/www.test.co.uk/mysql:/var/lib/mysql \
 -v /data/sites/www.test.co.uk:/DATA django
 ```
