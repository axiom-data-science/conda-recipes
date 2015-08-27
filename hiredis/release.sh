#!/bin/bash

NAME=hiredis
ORG=axiom-data-science

if [ $# -eq 0 ]; then
    echo "No version specified, exiting"
    exit 1
fi

# Build 2.7
conda build -c axiom-data-science --python 2.7 .
PACKAGE_PATH=`conda build --python 2.7 --output .`
for f in ./py27/**/$NAME*; do
    anaconda upload -u $ORG --force $PACKAGE_PATH
done

# Build 3.4
conda build -c axiom-data-science --python 3.4 .
PACKAGE_PATH=`conda build --python 3.4 --output .`
for f in ./py34/**/$NAME*; do
    anaconda upload -u $ORG --force $PACKAGE_PATH
done
