FROM arm64v8/ubuntu:20.04
LABEL maintainer="kyungseop.kim@gmail.com"
LABEL platform="arm64v8"
LABEL os="ubuntu"
LABEL app="mysql-cluster"

RUN groupadd -r mysql && useradd -r -g mysql mysql 
RUN apt update && apt install -y xz-utils libaio1 libnuma-dev pwgen libmecab2
WORKDIR /opt
ADD ./mysql-cluster-8.3.0-linux-glibc2.28-aarch64.tar.xz .
RUN mv mysql-cluster-8.3.0-linux-glibc2.28-aarch64 mysql-cluster
RUN mkdir -p /opt/mysql-cluster/data
ENV PATH "/opt/mysql-cluster/bin:${PATH}"
VOLUME /var/lib/mysql


COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
COPY cnf/my.cnf /etc/
COPY cnf/mysql-cluster.cnf /etc/
RUN mkdir -p /usr/local/mysql/mysql-cluster /var/lib/mysql-files
#RUN chown -R mysql:mysql /var/lib/mysql
WORKDIR /usr/local/mysql/mysql-cluster
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 3306 33060 2202 1186
HEALTHCHECK CMD /healthcheck.sh
CMD ["mysqld"]
