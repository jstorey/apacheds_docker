FROM dockerfile/java:oracle-java7

RUN apt-get update && apt-get install -y xinetd ldap-utils

ADD http://apache.tradebit.com/pub//directory/apacheds/dist/2.0.0-M19/apacheds-2.0.0-M19-amd64.deb /tmp/installer.deb
RUN dpkg -i /tmp/installer.deb 

ADD https://github.com/outbrain/zookeepercli/releases/download/v1.0.5/zookeepercli /bin/zk
RUN chmod 0755 /bin/zk
ADD files/health_check.sh /root/health_check.sh
ADD files/healthchk /etc/xinetd.d/healthchk

RUN echo 'healthchk      11001/tcp' >> /etc/services

EXPOSE 10389 10636 11001

ENTRYPOINT /opt/apacheds-2.0.0-M19/bin/apacheds console default
