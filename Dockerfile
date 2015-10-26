FROM ubuntu:14.04
MAINTAINER Kirnos Nikolay <nkirnos@gmail.com>
RUN apt-get update && apt-get install -y \
    curl wget curl git cron \
    php5-cli php5-mysql php5-mcrypt php5-curl && \
    rm -rf /var/lib/apt/lists/* && \
    php5enmod mcrypt

# Define working directory.
WORKDIR /

VOLUME "/var/www"
VOLUME "/tmp"

RUN echo '#!/bin/bash' > /init.sh && \
    echo 'if [ -n "$(tail -n1 /etc/crontab)" ]; then' >> /init.sh && \
    echo 'echo "" >> /etc/crontab' >> /init.sh && \
    echo 'fi' >> /init.sh && \
    echo 'rm -rf /tmp/*.lck' >> /init.sh && \
    echo 'crontab /etc/crontab' >> /init.sh && \
    echo 'cron -f' >> /etc/crontab
RUN chmod +x /init.sh
# Define default command.
CMD ["/init.sh"]