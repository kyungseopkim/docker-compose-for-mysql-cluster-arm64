FROM arm64v8/ubuntu:20.04
LABEL maintainer="jerrykim@lucidmotors.com"
LABEL platform="arm64v8"
LABEL os="ubuntu"
LABEL app="mysql-cluster"

#RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt update && apt install -y xz-utils libaio1
RUN mkdir -p /usr/local/mysql/mysql-cluster
WORKDIR /opt
ADD ./mysql-cluster-8.3.0-linux-glibc2.28-aarch64.tar.xz .
RUN mv mysql-cluster-8.3.0-linux-glibc2.28-aarch64 mysql-cluster
ENV PATH "/opt/mysql-cluster/bin:${PATH}"
VOLUME /var/lib/mysql


COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
COPY cnf/my.cnf /etc/
COPY cnf/mysql-cluster.cnf /etc/
WORKDIR /usr/local/mysql/mysql-cluster
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 3306 33060 2202 1186
HEALTHCHECK CMD /healthcheck.sh
CMD ["mysqld"]
