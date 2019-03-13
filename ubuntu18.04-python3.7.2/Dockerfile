FROM ubuntu:18.04

# use login bash shell as default
SHELL ["/bin/bash", "-lc"]

# install python, pip and pipenv
RUN apt-get update && \
    apt-get install -y curl git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev

# add the user Motoko, tribute to https://en.wikipedia.org/wiki/Motoko_Kusanagi
RUN useradd --create-home --groups root --no-log-init --system  motoko && \
	echo "motoko:kusanagi" | chpasswd
USER motoko
WORKDIR /home/motoko

# set some local environment variables
ENV LANG en_US.UTF-8

# install pyenv for motoko
RUN curl https://pyenv.run | bash

# update path to use pyenv
ENV PATH ~/.pyenv/bin:~/.local/bin:$PATH

# set the bashrc (for interactive sessions) and bash_profile (for login sessions)
RUN echo "eval \"\$(pyenv init -)\"" > ~/.bashrc && \
    echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc && \
	echo "eval \"\$(pyenv init -)\"" > ~/.bash_profile && \
    echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bash_profile

# install python 3.7.2, upgrade pip, and install pipenv
RUN pyenv update && \
	pyenv install 3.7.2 && \
	pyenv global 3.7.2 && \
	pip --no-cache-dir install --user --upgrade pip && \
	pip --no-cache-dir install --user --upgrade pipenv
