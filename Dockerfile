FROM ubuntu:18.04

ENV REFRESHED_AT=2018-08-16 \
    LANG=en_US.UTF-8 \
    HOME=/opt/build \
    TERM=xterm

WORKDIR /opt/build

RUN \
  apt-get update -y 
  
RUN \
  DEBIAN_FRONTEND=noninteractive TZ=Europe/Helsinki && apt-get install -y locales
  
RUN \ 
  locale-gen en_US.UTF-8 
RUN \
  apt-get install -y git wget vim gnupg 
RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm erlang-solutions_1.0_all.deb 
RUN \ 
  DEBIAN_FRONTEND=noninteractive TZ=Europe/Helsinki apt-get install tzdata
RUN \
  DEBIAN_FRONTEND=noninteractive TZ=Europe/Helsinki apt-get update -y && \
  apt-get install -y erlang elixir

RUN \ 
  apt-get install -y make
  
CMD ["/bin/bash"]