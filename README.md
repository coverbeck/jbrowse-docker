# jbrowse-docker
## JBrowse and Express (/docker-express/Dockerfile)
This will get JBrowse running with Express on port 3000.

Inspired by [enuggetry/docker-jbrowse](https://github.com/enuggetry/docker-jbrowse)

### Build the docker image

`docker build . -t jbrowse-express`

### Run the docker image

`docker run -p 3000:3000 jbrowse-express utils/jb_run.js -p 3000`