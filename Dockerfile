FROM ubuntu:14.04

#
# JAVA 8
#
RUN sudo apt-get update && \
    sudo apt-get -y install software-properties-common && \
    sudo add-apt-repository ppa:webupd8team/java && \
    sudo apt-get update && \
    echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | sudo /usr/bin/debconf-set-selections && \
    sudo apt-get -y install oracle-java8-set-default && \
    sudo apt-get clean

#
# ATLASSIAN SDK
#
RUN apt-get update && \
    sudo apt-get install apt-transport-https &&\
    echo "deb https://sdkrepo.atlassian.com/debian/ stable contrib" >>/etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B07804338C015B73 && \
    sudo apt-get update && \
    sudo apt-get install atlassian-plugin-sdk && \
    apt-get clean

#
# WORKDIR (WILL BE MOUNTED AS VOLUME)
#
RUN mkdir /opt/atlas/
WORKDIR /opt/atlas/

#
# INJECT MAVEN REPOSITORY MIRROR INTO SETTINGS (only local network)
#
ENV MAVEN_REPOSITORY_MIRROR http://build-local.codeclou.io:8081/artifactory/all/
RUN ATLAS_MAVEN_HOME=$(atlas-version | grep "ATLAS Maven Home" | awk '{print $4}') && \
    sed -i "s@<mirrors>@<mirrors><mirror><mirrorOf>*</mirrorOf><name>remote-repos</name><url>${MAVEN_REPOSITORY_MIRROR}</url><id>remote-repos</id></mirror>@g" $ATLAS_MAVEN_HOME/conf/settings.xml

#
# EXPOSE
#
EXPOSE 2990

#
# WILL BE OVERWRITTEN
#
CMD atlas-version
