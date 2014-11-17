# Django and Rails Development Machine
FROM ubuntu:14.04
MAINTAINER Udbhav Gupta <dev@udbhavgupta.com>
RUN apt-get update

# Set Locale for en_US.utf8
RUN locale-gen en_US.utf8
RUN for i in LANGUAGE LANG LC_ALL; do export $i=en_US.utf8; done;

# PostgresSQL

# add the repository
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# dependencies
RUN apt-get install -y wget ca-certificates

# get the key
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# update
RUN apt-get update

# install
RUN apt-get install -y postgresql-9.3

# python
RUN apt-get install -y python2.7

# Install packages for building ruby
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# Install multiple versions of ruby
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./ruby_versions.txt /root/ruby_versions.txt
RUN xargs -L 1 rbenv install < /root/ruby_versions.txt

# Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv global $v; gem install bundler; done'

# image processing
RUN apt-get install -y --force-yes libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev imagemagick

# memcached and redis
# RUN apt-get install -y --force-yes memcached redis