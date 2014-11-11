#
# Based on https://registry.hub.docker.com/u/dockerfile/mysql/dockerfile/
#
FROM centos:centos6
MAINTAINER Bill Schwanitz <bilsch@bilsch.org>
RUN /usr/bin/yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm && \
    /usr/bin/yum -y install Percona-Server-client-56 Percona-Server-server-56 && \
   /sbin/service mysql start && \
   echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
   echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
   bash /tmp/config && \
   rm -f /tmp/config
COPY my.cnf /etc/
EXPOSE 3306
ENTRYPOINT  ["/usr/sbin/mysqld"]
