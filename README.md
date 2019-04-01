# jbrowse-docker
## JBrowse and Express (/docker-express/Dockerfile)
This will get JBrowse running with Express on port 3000.

Inspired by [enuggetry/docker-jbrowse](https://github.com/enuggetry/docker-jbrowse)

### Dockerfile
#### Setup data
Place your track data in ./data. This maps to /jbrowse/data in the container, which is where JBrowse stores reference data and track information.

#### Build the docker image

`docker build . -t jbrowse-express`

#### Run the docker image
`docker run -p 3000:3000 -v ./data:/jbrowse/data jbrowse-express utils/jb_run.js -p 3000`

Note: You can run in the background using the detach mode (-d)

`docker run -d -p 3000:3000 -v ./data:/jbrowse/data jbrowse-express utils/jb_run.js -p 3000`

### Docker Compose
#### Build docker-compose
`docker-compose build`

#### Load refseq and tracks
If you already have your tracks.conf and seq/, etc., you can simply put these files into your `./data` directory.

As an example, we will load Chr1 as a reference sequence.

```
wget http://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.chromosome.1.fa.gz

jbrowse/bin/prepare-refseqs.pl --fasta Homo_sapiens.GRCh37.75.dna.chromosome.1.fa.gz
```

#### Run the docker-compose
`docker-compose up`

Note: You can run in the background using the detach mode (-d)

`docker-compose up -d`

#### Enter the Docker Container

You can enter the container by doing the following:

```
# Get container ID
docker ps

# Enter container
docker exec -it <container-id> /bin/bash
```

Now go to `localhost:3000` and you should see JBrowse with your refdata and tracks!