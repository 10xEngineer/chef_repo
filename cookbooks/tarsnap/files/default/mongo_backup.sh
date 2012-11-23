DATE=`date +%Y-%m-%d_%H-%M`

/usr/bin/mongodump -o /root/dump >/dev/null

/usr/local/bin/tarsnap --keyfile /root/.tarsnap/10xeng_gpi01-write --cachedir /root/.tarsnap/cache -c -f mongo_dump-${DATE} /root/dump 2>/dev/null