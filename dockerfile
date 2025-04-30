FROM centos:7

# Fix CentOS 7 repo (vault.centos.org since mirrors are deprecated)
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo

# Install Java and tools
RUN yum install -y java-11-openjdk net-tools curl && yum clean all

# Download Tomcat (using curl instead of ADD)
RUN curl -L -o /tmp/apache-tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.104/bin/apache-tomcat-9.0.104.tar.gz

# Extract Tomcat and rename
WORKDIR /opt
RUN tar -xvzf /tmp/apache-tomcat.tar.gz && \
    mv apache-tomcat-9.0.104 tomcat && \
    rm -f /tmp/apache-tomcat.tar.gz

# Copy your WAR file into Tomcat's webapps
COPY project.war /opt/tomcat/webapps/

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
