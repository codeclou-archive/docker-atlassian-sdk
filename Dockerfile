FROM codeclou/docker-oracle-jdk:8u131

ENV ATLS_VERSIN 6.2.14
ENV ATLS_SHA512 48ad1d0c8ee725ee0e6753231e061ac04da54167797429d39ed8a4815b6705d0fc643794bf767809d819fc22039fe8923e8a94bb9aa3bf2a6e32a25f53039153

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
    echo "${ATLS_SHA512}  /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz" > /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz.sha512 && \
    curl -jkSL -o /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz \
         https://maven.atlassian.com/content/repositories/atlassian-public/com/atlassian/amps/atlassian-plugin-sdk/${ATLS_VERSIN}/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz && \
    sha512sum -c /opt/atlassian-plugin-sdk-${ATLS_VERSIN}.tar.gz.sha512

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
