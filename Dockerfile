FROM ubuntu:20.04

RUN sed 's#ports.ubuntu.com#mirrors.aliyun.com#g' /etc/apt/sources.list -i
RUN apt update && \
    apt install -y python3 python3-setuptools python3-pip memcached libmemcached-dev pwgen sqlite3 wget && \
    apt clean
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple/ django==2.2.* future Pillow pylibmc captcha jinja2 psd-tools django-pylibmc django-simple-captcha && \
    rm -r /root/.cache

RUN wget http://192.168.192.178:9000/github.com/haiwen/seafile-rpi/releases/download/v8.0.7/seafile-server-8.0.7-buster-arm64v8.tar.gz && \
    mkdir -p /opt/seafile/conf && \
    tar -xf seafile-server-8.0.7-buster-arm64v8.tar.gz -C /opt/seafile/ && \
    rm seafile-server-8.0.7-buster-arm64v8.tar.gz && \
    find /opt/seafile/ -name 'Pillow*' |xargs rm -r && \
    find /opt/seafile/ -name 'PIL*'|xargs rm -r

ADD configuration.tar.gz /opt/seafile

RUN cd /opt/seafile/seafile-server-8.0.7/seahub/media && \
    rm -r avatars && \
    ln -s ../../../seahub-data/avatars/

RUN apt install -y locales && \
    localedef -f UTF-8 -i zh_CN zh_CN.UTF-8
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

RUN useradd seafile && \
    chown seafile:seafile /opt/seafile/ && \
    ulimit -n 30000
USER seafile:seafile

ENV PATH=$PATH:/opt/seafile/seafile-server-latest/
#ENV SEAFILE_SERVICE_PORT=8082
#ENV SEAFILE_HUB_PORT=8000
#
#EXPOSE $SEAFILE_SERVICE_PORT $SEAFILE_HUB_PORT

COPY entrypoint /
ENTRYPOINT /entrypoint
