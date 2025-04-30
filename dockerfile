FROM centos:7
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y java-11-openjdk
RUN yum install -y net-tools

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.104/bin/apache-tomcat-9.0.104.tar.gz 

WORKDIR /opt
RUN tar -xvzf /tmp/apache-tomcat.tar.gz && \
    mv apache-tomcat-10.1.9 tomcat

COPY project.war /opt/tomcat/webapps/

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
