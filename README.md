# docker-atlassian-sdk
Docker Image to run Atlassian SDK Commands.

![](https://codeclou.github.io/doc/docker-warranty.svg?v5)

-----

### Usage

Assuming you have your e.g. JIRA© Plugin Source in `myproject`.
You can then run `atlas-package` via this command:

```
cd myproject

docker run \
    --tty \
    --volume $(pwd)/:/opt/atlas \
    -e "ENV MAVEN_REPOSITORY_MIRROR=http://yourserver:8081/artifactory/all/" \
    codeclou/docker-atlassian-sdk:latest atlas-package
```

-----

### Mandatory Maven-Repository (Artifactory)

**WARN:** You **must have a [JFrog Artifactory service](https://www.jfrog.com/open-source/) (or similiar) runnning** with a Virtual Repository that mirrors at least the following **Maven Repositories**:

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

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-atlassian-sdk/blob/master/LICENSE.md)
  * [Atlassian Plugin SDK](https://developer.atlassian.com/docs/getting-started/set-up-the-atlassian-plugin-sdk-and-build-a-project) might be licensed differently. Please check for yourself.
  * [Oracle Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) might be licensed differently. Please check for yourself.
    * Note: By using this docker image you automatically accept the License Terms of Oracle Java 8 JDK.
