FROM alpine:3.6

MAINTAINER rannuo "rannuo@gmail.com"

ENV FASTDFS_PATH=/opt/fdfs \
    FASTDFS_BASE_PATH=/var/fdfs \
    HOME=/root

#get all the dependences
RUN apk update && apk add --no-cache --virtual .build-deps bash gcc libc-dev make openssl-dev pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev

#create the dirs to store the files downloaded from internet
RUN mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH}

RUN cd ${HOME} \
    && curl -fSL https://github.com/happyfish100/libfastcommon/archive/V1.0.36.tar.gz -o libfastcommon.tar.gz \
    && curl -fSL  https://codeload.github.com/happyfish100/fastdfs/tar.gz/V5.11 -o fastfs.tar.gz \
    && tar zxf libfastcommon.tar.gz \
    && tar zxf fastfs.tar.gz

# compile and install the libfastcommon
RUN cd ${HOME}/libfastcommon-1.0.36/ \
    && ./make.sh \
    && ./make.sh install

# compile and install the fastdfs
RUN cd ${HOME}/fastdfs-5.11/ \
    && ./make.sh \
    && ./make.sh install

EXPOSE 22122 23000 8080 8888
VOLUME ["$FASTDFS_BASE_PATH", "/etc/fdfs"]   

COPY conf/*.* /etc/fdfs/

COPY fastdfs.sh /usr/bin/

#make the start.sh executable 
RUN chmod 777 /usr/bin/fastdfs.sh

ENTRYPOINT ["/usr/bin/fastdfs.sh"]
CMD ["tracker"]
