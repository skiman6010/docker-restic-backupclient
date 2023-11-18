FROM arm32v7/lpine:3.17

RUN \
    # install restic \
    apk add --update --no-cache restic bash restic-bash-completion curl && \
    # install python and tools \
    apk add --update --no-cache tzdata python3 py3-pip py3-requests py3-yaml gzip findutils && \
    pip3 install crontab && \
    # install elasticdump \
    apk add --update --no-cache npm && \
    npm install -g elasticdump && \
    # install mysql client
    apk add --update --no-cache mariadb-client  && \
    # with modern authentication method
    apk add --update --no-cache mariadb-connector-c && \
    # install postgresql client
    apk add --update --no-cache postgresql-client && \
    # install influxdb \
    apk add --update --no-cache influxdb && \
    # ensure glibc program compability for added mongodump_rc binary
    apk add --update --no-cache krb5-libs gcompat

WORKDIR /usr/bin/

ENV BACKUP_ROOT=/backup

VOLUME /backup

ADD *.py /scripts/

CMD /scripts/backup_client.py schedule @daily
