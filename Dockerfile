FROM ubuntu:18.04

ARG BUILD_DATE=unspecified

# install python, pip and pipenv
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
	pip3 install --user pipenv
	
# set environment variables to make pipenv usable
ENV C_ALL C.UTF-8 
ENV LANG C.UTF-8
RUN echo "export PATH=$PATH:$(python3 -m site --user-base)/bin" >> /root/.bashrc
