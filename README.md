# docker-atlassian-sdk

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-323.svg?v2)](https://hub.docker.com/r/codeclou/docker-atlassian-sdk/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Docker-Image to run [Atlassian Pugin SDK](https://developer.atlassian.com/display/DOCS/Getting+Started) Commands.
Includes [Oracle Java 8 JDK](https://www.oracle.com/java/) and [glibc](https://github.com/sgerrand/alpine-pkg-glibc).


-----

&nbsp;

### Prerequisites

 * Runs as non-root with fixed UID 10777 and GID 10777. See [howto prepare volume permissions](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * See [howto use SystemD for named Docker-Containers and system startup](https://github.com/codeclou/doc/blob/master/docker/README.md).

-----

&nbsp;

### Usage

Assuming you have your e.g. JIRA© Plugin Source in `myproject`.
You can then run [`atlas-package`](https://developer.atlassian.com/docs/developer-tools/working-with-the-sdk/command-reference/atlas-package) with the following command.

```bash
cd myproject
docker run \
    -i -t \
    --volume $(pwd)/:/opt/atlas \
    codeclou/docker-atlassian-sdk:latest \
    atlas-package

## OR

docker run \
    -i -t \
    --volume $(pwd)/:/opt/atlas \
    codeclou/docker-atlassian-sdk:sdk-6.2.14 \
    atlas-package
```

Run a certain JIRA© Version standalone for testing. (Note: On macOS it might be very slow to use VOLUME)

```
docker run \
    -i -t \
    -p 2990:2990 \
    --volume $(pwd)/:/opt/atlas \
    -e MAVEN_REPOSITORY_MIRROR="http://build-local.codeclou.io:8081/artifactory/all/" \
    codeclou/docker-atlassian-sdk:latest \
    atlas-run-standalone --version 7.3.0 --product jira --http-port 2990 --server 0.0.0.0 \
                         --jvmargs -Xmx4096M -DskipAllPrompts=true
```

Then go to http://localhost:2990/jira/

-----

&nbsp;

### Usage with Maven-Repository-Mirror

```bash
docker run \
    -i -t \
    --volume $(pwd)/:/opt/atlas \
    -e MAVEN_REPOSITORY_MIRROR="http://build-local.codeclou.io:8081/artifactory/all/" \
    codeclou/docker-atlassian-sdk:latest \
    atlas-package
```

You **need to have a [JFrog Artifactory service](https://www.jfrog.com/open-source/) (or similiar) runnning** with a Virtual Repository that mirrors at least the following **Maven Repositories**:

```
https://maven.atlassian.com/3rdparty/
https://maven.atlassian.com/public/
https://maven.atlassian.com/public-snapshot/
https://repo.maven.apache.org/maven2/
https://repo.spring.io/release
https://repo.spring.io/milestone
https://repo.spring.io/snapshot
https://maven.java.net/content/groups/public/
http://maven.jahia.org/maven2/
```

The URL to the Maven Repository Mirror is set via the `MAVEN_REPOSITORY_MIRROR` ENV Variable.

-----
&nbsp;

### License, Liability & Support

 * [![](https://codeclou.github.io/doc/docker-warranty-notice.svg?v1)](https://github.com/codeclou/docker-atlassian-sdk/blob/master/LICENSE.md)
 * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-atlassian-sdk/blob/master/LICENSE.md)
 * [Atlassian Plugin SDK](https://developer.atlassian.com/docs/getting-started/set-up-the-atlassian-plugin-sdk-and-build-a-project) might be licensed differently. Please check for yourself.
 * [Oracle Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) might be licensed differently. Please check for yourself.
   * Note: By using this docker image you automatically accept the License Terms of Oracle Java 8 JDK and Atlassian SDK.
