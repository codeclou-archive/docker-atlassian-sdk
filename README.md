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

:bangbang: **WARN:** This can only be used in local codeclou network, since a global maven-repository mirror is set which is not available on the internet!

-----

:bangbang: IT IS NOT ADVISED TO USE THIS IMAGE DIRECTLY. CHECK THE DOCKERFILE AND CREATE YOUR OWN CUSTOM IMAGE :bangbang:

-----

### License

  * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-atlassian-sdk/edit/master/LICENSE.md)
  * [Atlassian Plugin SDK](https://developer.atlassian.com/docs/getting-started/set-up-the-atlassian-plugin-sdk-and-build-a-project) might be licensed differently. Please check for yourself.
  * [Oracle Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) might be licensed differently. Please check for yourself.
