#!/bin/bash

NAME=pyinotify
ORG=axiom-data-science

if [ $# -eq 0 ]; then
    echo "No version specified, exiting"
    exit 1
fi

# Build 2.7
conda build -c axiom-data-science --python 2.7 .
PACKAGE_PATH=`conda build --python 2.7 --output .`
conda convert --platform linux-32 $PACKAGE_PATH -o ./py27
conda convert --platform linux-64 $PACKAGE_PATH -o ./py27
conda convert --platform osx-64 $PACKAGE_PATH -o ./py27
for f in ./py27/**/$NAME*; do
    anaconda upload -u $ORG --force $f
done
rm -r ./py27

# Build 3.4
conda build -c axiom-data-science --python 3.4 .
PACKAGE_PATH=`conda build --python 3.4 --output .`
conda convert --platform linux-32 $PACKAGE_PATH -o ./py34
conda convert --platform linux-64 $PACKAGE_PATH -o ./py34
conda convert --platform osx-64 $PACKAGE_PATH -o ./py34
for f in ./py34/**/$NAME*; do
    anaconda upload -u $ORG --force $f
done
rm -r ./py34
