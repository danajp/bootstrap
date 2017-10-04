FROM ubuntu:17.04

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y software-properties-common \
  && apt-add-repository ppa:ansible/ansible

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y ansible sudo python-jmespath

RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/passwordless

RUN useradd -G sudo dana
COPY . /home/dana/bootstrap
RUN chown -R dana:dana /home/dana
WORKDIR /home/dana/bootstrap
USER dana
