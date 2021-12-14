FROM ubuntu:20.04

WORKDIR /dump

RUN apt update
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get install -y tzdata gnupg wget
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt update 
RUN apt-get install -y mongodb-org curl unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -rf awscliv2.zip aws
RUN aws --version

CMD ["bash"]
