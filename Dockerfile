FROM codeclou/docker-oracle-jdk:8u152

ARG ATLS_VERSIN=6.3.15

#
# BASE PACKAGES + DOWNLOAD GLIBC & ORACLE JAVA & ATLASSIAN SDK
#
RUN apk add --no-cache \
            bash \
            ca-certificates \
            http-parser \
            libcrypto1.0 \
            libssl1.0 \
            libstdc++ \
            libuv \
            musl \
            zlib \
            curl \
            gzip \
            tar && \
    mkdir -p /opt/atlas/ && \
    mkdir -p /opt/atlas-work/ && \
    echo "=== INSTALLING ATLASSIAN SDK==================" && \
    curl -jkSL -o /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz \
         https://maven.atlassian.com/content/repositories/atlassian-public/com/atlassian/amps/atlassian-plugin-sdk/${ATLS_VERSIN}/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz

#
# INSTALL AND CONFIGURE
#
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh
RUN chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh && \
    addgroup -g 10777 worker && \
    adduser -D -G worker -u 10777 worker && \
    chown -R worker:worker /opt/atlas/ && \
    chmod -R u+rwx,g+rwx,o-rwx /opt/atlas/ && \
    chown -R worker:worker /opt/atlas-work/ && \
    chmod -R u+rwx,g+rwx,o-rwx /opt/atlas-work/ && \
    tar -C /opt -xf /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz && \
    chown -R worker:root /opt/atlassian-plugin-sdk-${ATLS_VERSIN} && \
    rm -f /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz && \
    apk del curl gzip tar && \
    rm -rf /tmp/* /var/cache/apk/*

#
# RUN
#
EXPOSE 2990
USER worker
ENV MAVEN_REPOSITORY_MIRROR "false"
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:/opt/atlassian-plugin-sdk-${ATLS_VERSIN}/bin/:/opt/jdk/bin/
WORKDIR /opt/atlas/
VOLUME ["/opt/atlas/"]
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["atlas-version"]
