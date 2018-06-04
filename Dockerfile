# Docker will pull from docker.io if base image does not already exist in local Docker repo
FROM centos:centos7

# Feel free to modify this
MAINTAINER "Some dude?!"

WORKDIR .

# Docker is to execute all subsequent commands in this file as BusyBox's root user
USER root

# Ensure that shell script added to image is set as executable
RUN yum -y update && yum -y install openldap-clients && yum clean all
RUN mkdir /scripts && chmod 777 /scripts
COPY ./looper.sh /scripts
RUN chmod +x /scripts/looper.sh

USER 1001

# Our script uses the command line parameters passed as part of $NAME env var
CMD /scripts/looper.sh
