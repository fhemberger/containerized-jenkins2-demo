FROM jenkinsci/jenkins:2.44

USER root

RUN apt-get update -qq && \
  apt-get install -y apt-transport-https ca-certificates && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
  apt-get update -qq && \
  apt-get install -y docker-engine && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log

# The jenkins user must be added to the docker group so it has permission to run Docker
RUN usermod -aG docker jenkins

USER jenkins

COPY plugins.txt /tmp
RUN /usr/local/bin/install-plugins.sh `cat /tmp/plugins.txt | tr '\n' ' '`
