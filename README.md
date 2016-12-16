# docker-atlassian-sdk
Docker Image to run Atlassian SDK Commands from Docker Image


### Build with 'atlas-package'

Assuming you have your e.g. JIRA© Plugin Source in `myproject`.
You can then run `atlas-package` via this command:

```
cd myproject

docker run --tty --volume $(pwd)/:/opt/atlas codeclou/docker-atlassian-sdk:latest atlas-package
```

-----

:bangbang: **WARN:** This can only be used in local codeclou network, since a global maven-repository mirror is set which is not available on the internet! You must have a *[artifactory](https://www.jfrog.com/open-source/) installed somehwere* with a Virtual Repository that contains at least these Maven Repositories:

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

Now you can run atlas-package and override the `ENV` variable with the Maven Repository Mirror URL:

```
docker run --tty --volume $(pwd)/:/opt/atlas \
                 -e "ENV MAVEN_REPOSITORY_MIRROR=http://yourserver:8081/artifactory/all/" \
                 codeclou/docker-atlassian-sdk:latest atlas-package    
```

----

:bangbang: IT IS NOT ADVISED TO USE THIS IMAGE DIRECTLY. CHECK THE DOCKERFILE AND CREATE YOUR OWN CUSTOM IMAGE :bangbang:

-----

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-atlassian-sdk/edit/master/LICENSE.md)
  * [Atlassian Plugin SDK](https://developer.atlassian.com/docs/getting-started/set-up-the-atlassian-plugin-sdk-and-build-a-project) might be licensed differently. Please check for yourself.
  * [Oracle Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) might be licensed differently. Please check for yourself.
