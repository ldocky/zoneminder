# zoneminder
ZoneMinder Docker Build with SSL support


sudo docker create \
--name=zoneminder \
--restart=always \
--shm-size=512m \
-v /localconfigpath:/config:rw \
-v /localcachepath:/var/cache/zoneminder \
-v /etc/localtime:/etc/localtime:ro \
-e TMZ=Europe/London \
-p 80:80 \
-p 443:443 \
ldocky/zoneminder


The script will create self signed cert for the ssl site under /config/, this can be replaced with proper certificate
