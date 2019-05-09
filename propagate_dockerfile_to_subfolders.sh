#!/bin/bash

for folder in ubuntu*-python*
do
    # clean the folder and copy the Dockerfile template (contained in the root folder)
    rm -r -f $folder/*
    cp Dockerfile $folder/
    
    # extract the ubuntu tag and the python version to use from the folder name
    ubuntu_tag=$( echo $folder | sed 's/ubuntu\([0-9\.]*\)-python.*/\1/' )
    python_version=$( echo $folder | sed 's/ubuntu[0-9\.]*-python\([0-9\.]*\)/\1/' )
    
    # insert the ubuntu tag and python version in the Dockerfile
    sed -i.bak "s/UBUNTU_TAG/$ubuntu_tag/" $folder/Dockerfile
    sed -i.bak "s/PYTHON_VERSION/$python_version/" $folder/Dockerfile
    rm -f $folder/*.bak
    
done