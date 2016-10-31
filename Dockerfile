FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y ruby vagrant git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN git config --global user.email "jenkins@ci.twiket.com"
RUN git config --global user.name "Jenkins"
RUN mkdir ~/.chef
COPY ./config/knife.rb ~/.chef/

RUN mkdir /opt/chef-test
COPY . /opt/chef-test
RUN cd /opt/chef-test; bundle install

ENV PATH /opt/chef-test/bin:$PATH

WORKDIR /workdir
