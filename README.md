# docker-ubuntu-with-pipenv

Dockerfile that generates a docker image with Ubuntu and a user `motoko` that has [pyenv](https://github.com/pyenv/pyenv) with python, pip, and [pipenv](https://pipenv.readthedocs.io/en/latest/) pre-installed.

When a container is run using this image, the commands are run automatically as `motoko` user.

This is intended for simulating a real-case scenario, where a user wants to have pyenv installed at a user level, to avoid messes with root bins.



## Example 1: interactive mode

```bash
docker container run -it francesco086/pipenv

motoko@...:~$ pyenv versions
* 3.7.2 (set by /home/motoko/.pyenv/version)

motoko@...:~$ mkdir myproject
motoko@...:~$ cd myproject
motoko@...:~$ pipenv install requests
motoko@...:~$ ls
Pipfile  Pipfile.lock
```


## Example 2: build image with pipenv already installed

You have a Pipfile:

```
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[dev-packages]

[packages]
pandas = "*"
numpy = "*"
sqlalchemy = "*"
scipy = "*"

[requires]
python_version = "3.7"
```

You can generate a docker image (say `you/my_env`) with a Dockerfile like this:

```
FROM francesco086/pipenv

COPY Pipfile /app/
WORKDIR /app

RUN pipenv install
```

Then you can do:
```bash
docker container run -it you/my_env

motoko@...:~$ pipenv shell
Launching subshell in virtual environment…
 . /home/motoko/.local/share/virtualenvs/app-4PlAip0Q/bin/activate
motoko@eac5a40ca71f:/app$  . /home/motoko/.local/share/virtualenvs/app-4PlAip0Q/bin/activate

motoko@...:~$ ipython
Python 3.7.2 (default, Mar 13 2019, 14:41:35) 
Type 'copyright', 'credits' or 'license' for more information
IPython 7.3.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]:  import pandas as pd

In [2]: pd.Series([1,2,3]).apply(lambda x: x*2)                                                                                                                                               
Out[2]: 
0    2
1    4
2    6
dtype: int64
```