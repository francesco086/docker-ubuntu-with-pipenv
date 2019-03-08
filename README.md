# docker-ubuntu-with-pipenv

Dockerfile that generates a docker image with Ubuntu and a user `motoko` that has [pyenv](https://github.com/pyenv/pyenv) with python, pip, and [pipenv](https://pipenv.readthedocs.io/en/latest/) pre-installed.

When a container is run using this image, the commands are run automatically as `motoko` user.

This is intended for simulating a real-case scenario, where a user wants to have pyenv installed at a user level, to avoid messes with root bins.

E.g.

```bash
docker container run -it francesco086/pipenv

motoko@4bdfe04a4e0b:~$ pyenv versions
* 3.7.2 (set by /home/motoko/.pyenv/version)


```