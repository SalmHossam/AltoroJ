FROM tomcat:7.0.109-jdk8-openjdk
RUN apt-get install -y git unzip && \
    cd /tmp && \
    wget https://services.gradle.org/distributions/gradle-3.0-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-3.0-bin.zip && \
    rm gradle-3.0-bin.zip
WORKDIR /AltoroJ-AltoroJ-3.2/AltoroJ-AltoroJ-3.2/
COPY AltoroJ-AltoroJ-3.2/. .
RUN --mount=type=cache,target=/root/.gradle/caches \
    /opt/gradle/gradle-3.0/bin/gradle build && cp ./build/libs/altoromutual.war /usr/local/tomcat/webapps
EXPOSE 8079
CMD ["catalina.sh", "run"]
