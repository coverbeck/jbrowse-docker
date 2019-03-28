FROM ubuntu:latest

ENV JBROWSE_VERSION 1.16.3

RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install git build-essential zlib1g-dev libxml2-dev libexpat-dev postgresql-client libpq-dev ca-certificates curl

# Download JBrowse
RUN mkdir -p /jbrowse/ && \
    git clone --recursive https://github.com/gmod/jbrowse /jbrowse/ && \
    cd /jbrowse/ && \
    git checkout ${JBROWSE_VERSION}-release

# Install node and JBrowse
RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

ENV NVM_DIR ${HOME}/.nvm
ENV NODE_VERSION 10.15.3

WORKDIR /jbrowse/

RUN . ${HOME}/.nvm/nvm.sh && nvm install ${NODE_VERSION} && \
    nvm use ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION} && \
    nvm use default && \
    ./setup.sh && \
    ./bin/cpanm --force JSON Hash::Merge PerlIO::gzip Devel::Size \
    Heap::Simple Heap::Simple::XS List::MoreUtils Exception::Class Test::Warn Bio::Perl \
    Bio::DB::SeqFeature::Store File::Next Bio::DB::Das::Chado && \
    rm -rf /root/.cpan/

ENV NODE_PATH ${NVM_DIR}/v${NODE_VERSION}/lib/node_modules
ENV PATH ${NVM_DIR}/v${NODE_VERSION}/bin:${PATH}

EXPOSE 80