# jbrowse-docker
## JBrowse and Express
This will get JBrowse running with Express on port 3000.

Based on [enuggetry/docker-jbrowse](https://github.com/enuggetry/docker-jbrowse)

### Dockerfile
#### Setup data
*Important*: Place your track data in `./data`. This maps to `/jbrowse/data` in the container, which is where JBrowse stores reference data and track information.

#### Build the docker image
You'll have 3 options to choose from, and you should build the dockerfile in the corresponding folder. One is a general JBrowse Express image. The other two are similar images but with either the ICGC or GDC JBrowse plugins installed. You can find more information about them at [icgc-viewer](https://github.com/agduncan94/icgc-viewer) and [gdc-viewer](https://github.com/agduncan94/gdc-viewer).

`docker build . -t <tag-name>`

#### Run the docker image
`docker run -p 3000:3000 -v {pwd}/data:/jbrowse/data <tag-name> utils/jb_run.js -p 3000`

Note: You can run in the background using the detach mode (-d)

`docker run -d -p 3000:3000 -v {pwd}/data:/jbrowse/data <tag-name> utils/jb_run.js -p 3000`

### Docker Compose
#### Build docker-compose
`docker-compose build`

#### Run the docker-compose
`docker-compose up`

Note: You can run in the background using the detach mode (-d)

`docker-compose up -d`

#### Load refseq and tracks
If you already have your tracks.conf and seq/, etc., you can simply put these files into your `./data` directory.

As an example, we will load Chr1 (GRCh37) as a reference sequence. Unfortunately you need JBrowse to prepare refseq, so you can either go into the docker container and run the following or clone JBrowse on your host system, run `./setup.sh` and then run the following on the host.

Note that GRCh37 is used for ICGC and GRCh38 is used for GDC.

```
# Download a FASTA file
wget http://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.chromosome.1.fa.gz

# Prepare refseqs
jbrowse/bin/prepare-refseqs.pl --fasta ./data/Homo_sapiens.GRCh37.75.dna.chromosome.1.fa.gz
```

Now go to `localhost:3000` and you should see JBrowse with your refdata and tracks!

#### Enter the Docker Container

You can enter the container by doing the following:

```
# Get container ID
docker ps

# Enter container
docker exec -it <container-id> /bin/bash
```