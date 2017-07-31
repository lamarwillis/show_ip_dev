# For show_ip development

FROM ubuntu:16.04
ARG user

# Prepare for sshd
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd && ls -ld /var/run/sshd
 
# Install development tools, postgresql, rabbit mq and friends using apt-get
RUN apt-get update \
  && apt-get install -y python3-pip \
  git="1:2.7.4*" \
  lynx \
  sudo \
  curl \
  netcat \
  net-tools \
  openssh-server \
  vim \
  wget \
  nano
 
# Upgrade pip3 (which oddly enough will create a 'pip' script)
RUN pip3 install --upgrade pip

# Install dev tools using pip3
RUN pip install boto3 virtualenv

# Configure user's account.
RUN /usr/sbin/adduser --disabled-password --gecos '' $user && \
  echo $user":password" | chpasswd
RUN bash -c 'echo $user" ALL=(ALL) NOPASSWD:ALL" | (EDITOR="tee -a" visudo)'

# Fix permissions.
RUN chown -R $user:$user /home/$user

# sshd ports
EXPOSE 22

# Start sshd in the foreground.
CMD /usr/sbin/sshd -D
