# unplatform-docker
unplatform docker container with syncthing



#Usage Instructions

```docker build . -t alpesh/unplatform:v0.6```

```docker run --detach --name unplatform -p 80:80 alpesh/unplatform:v0.6```
 

#TODO

1. Define unplatform folders that syncthing will sync

2. Provide custom wsgi.py