FROM ubuntu:18.04

ARG BUILD_DATE=unspecified

# use bash as default
SHELL ["/bin/bash", "-c"]

# install python, pip and pipenv
RUN apt-get update && \
    apt-get install -y curl git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev

# add the user Motoko, tribute to https://en.wikipedia.org/wiki/Motoko_Kusanagi
RUN useradd --create-home --groups root --shell /bin/bash motoko && \
	echo "motoko:kusanagi" | chpasswd
USER motoko
WORKDIR /home/motoko

# install pyenv for motoko
RUN curl https://pyenv.run | bash

# update path to use pyenv
ENV PATH /home/motoko/.pyenv/bin:/home/motoko/.local/bin:$PATH

# set some other local environment variables
ENV LANG "en_US.UTF-8"

# set the bashrc
RUN echo "eval \"\$(pyenv init -)\"" >> .bashrc && \
    echo "eval \"\$(pyenv virtualenv-init -)\"" >> .bashrc
		
# install python 3.7.2, upgrade pip, and install pipenv
RUN eval "$(pyenv init -)" && \
	eval "$(pyenv virtualenv-init -)" && \
	pyenv update && \
	pyenv install 3.7.2 && \
	pyenv global 3.7.2 && \
	pip --no-cache-dir install --user --upgrade pip pipenv
