FROM ubuntu:18.04
MAINTAINER create by Ross
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y wget ssh mc
RUN wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb
RUN dpkg -i zabbix-release_4.0-2+bionic_all.deb
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-agent
ENV MYSQL_ROOT_PASSWORD=Kjiflrf28@
ENV MYSQL_DATABASE=zabbix
ENV MYSQL_USER=zabbix_admin
ENV MYSQL_PASSWORD=zabixx@
CMD cp -f configs/.my.cnf /root/.my.cnf
CMD mysqladmin create zabbix
CMD zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql zabbix
CMD cp -f configs/zabbix_server.conf /etc/zabbix/zabbix_server.conf
CMD cp -f configs/zabbix.conf /etc/apache2/conf-enabled/zabbix.conf
CMD service zabbix-server start
CMD service zabbix-agent start
CMD update-rc.d zabbix-server enable && update-rc.d zabbix-agent enable
