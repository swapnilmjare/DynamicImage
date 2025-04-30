FROM centos:7

# Set proxy here if needed
# ENV http_proxy=http://your.proxy:port
# ENV https_proxy=http://your.proxy:port

# Install required packages
RUN yum install -y java-11-openjdk curl net-tools

# Download Tomcat using IPv4 to avoid IPv6 issues
RUN curl -4 -o /tmp/apache-tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.9/bin/apache-tomcat-10.1.9.tar.gz

# Extract and clean up
WORKDIR /opt
RUN tar -xvzf /tmp/apache-tomcat.tar.gz && \
    mv apache-tomcat-10.1.9 tomcat && \
    rm -f /tmp/apache-tomcat.tar.gz

# Copy your WAR file
COPY project.war /opt/tomcat/webapps/

# Expose port
EXPOSE 8080

# Set entrypoint
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
