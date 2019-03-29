FROM node:latest

ENV JBROWSE_VERSION 1.16.3

# Install dependencies
RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install git build-essential zlib1g-dev libxml2-dev libexpat-dev postgresql-client libpq-dev ca-certificates curl

# Download JBrowse
RUN mkdir -p /jbrowse/ && \
    git clone --recursive https://github.com/gmod/jbrowse /jbrowse/ && \
    cd /jbrowse/ && \
    git checkout ${JBROWSE_VERSION}-release

WORKDIR /jbrowse/

# Download ICGC Viewer
RUN git clone https://github.com/agduncan94/icgc-viewer /icgc-viewer/ && \
    cd /icgc-viewer/ && \
    git checkout develop && \
    cp -r icgc-viewer /jbrowse/plugins/icgc-viewer && \
    cat ./data/jbrowse.conf > /jbrowse/jbrowse.conf

# Setup JBrowse
RUN ./setup.sh && \
    ./bin/cpanm --force JSON Hash::Merge PerlIO::gzip Devel::Size \
    Heap::Simple Heap::Simple::XS List::MoreUtils Exception::Class Test::Warn Bio::Perl \
    Bio::DB::SeqFeature::Store File::Next Bio::DB::Das::Chado && \
    rm -rf /root/.cpan/

# Download reference data
RUN for i in $(seq 1 2); do wget http://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.chromosome.${i}.fa.gz; bin/prepare-refseqs.pl --fasta Homo_sapiens.GRCh37.75.dna.chromosome.${i}.fa.gz; done

# Expose port 3000
EXPOSE 3000