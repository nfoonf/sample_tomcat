# Centos based container with Java and Tomcat
FROM centos:centos7
MAINTAINER michael.groening@silpion.de

# Install prepare infrastructure
RUN yum -y update && \
	yum -y install wget && \
	yum -y install net-tools && \
	yum -y install tar

# Prepare environment

# Put the names of the java and tomcat archives here:
ENV JAVA_ARCHIVE jre-8u73-linux-x64.tar.gz
ENV TOMCAT_ARCHIVE apache-tomcat-8.0.30.tar.gz
ENV JAVA_DIR /opt/jre1.8.0_73
ENV TOMCAT_DIR /opt/apache-tomcat-8.0.30
ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts


ADD $JAVA_ARCHIVE /opt

ADD $TOMCAT_ARCHIVE /opt


#RUN mv /opt/jre1.8.0_73 opt/java && \
#    mv /opt/apache-tomcat-8.0.30 /opt/tomcat
RUN mv $JAVA_DIR $JAVA_HOME && \
    mv $TOMCAT_DIR $CATALINA_HOME

# uncomment if you want to put the Webapp directly into the Dockerfile
ADD sample.war /opt/tomcat/webapps/
# Add user jenkins to the image
RUN adduser jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

RUN yum -y install openssh-server
# Standard SSH port
EXPOSE 22
EXPOSE 8080

WORKDIR $CATALINA_HOME
#CMD ["/usr/sbin/sshd", "-D"]
CMD ["catalina.sh", "run"]
