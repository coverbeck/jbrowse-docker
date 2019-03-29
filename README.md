# jbrowse-docker
## JBrowse and Express (/docker-express/Dockerfile)
This will get JBrowse running with Express on port 3000.

Inspired by [enuggetry/docker-jbrowse](https://github.com/enuggetry/docker-jbrowse)

### Dockerfile
#### Build the docker image

`docker build . -t jbrowse-express`

#### Run the docker image

`docker run -p 3000:3000 jbrowse-express utils/jb_run.js -p 3000`

Note: You can run in the background using the detach mode (-d)
`docker run -d -p 3000:3000 jbrowse-express utils/jb_run.js -p 3000`

### Docker Compose
If you want to use a shared volume, you should use docker-compose to set up JBrowse.

#### Build docker-compose
`docker-compose build`

#### Run the docker-compose
`docker-compose up`

Note: You can run in the background using the detach mode (-d)

`docker-compose up -d`

#### Load refseq and tracks
If you already have your tracks.conf and seq/, etc., you can simply put these files into your `./data` directory.

You can enter the container by doing the following:

`docker ps` to find the container ID

`docker exec -it <container-id> /bin/bash`

Now go to 'localhost:3000' and you should see JBrowse with your refdata and tracks!