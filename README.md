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
