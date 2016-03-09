#!/bin/bash

NAME=blinker
ORG=axiom-data-science

if [ $# -eq 0 ]; then
    echo "No version specified, exiting"
    exit 1
fi

# Build 2.7
conda build --python 2.7 .
PACKAGE_PATH=`conda build --python 2.7 --output .`
conda convert --platform linux-32 $PACKAGE_PATH -f -o ./py27
conda convert --platform linux-64 $PACKAGE_PATH -f -o ./py27
for f in ./py27/**/$NAME*; do
    anaconda upload -u $ORG --force $f
done
rm -r ./py27

# Build 3.4
conda build --python 3.4 .
PACKAGE_PATH=`conda build --python 3.4 --output .`
conda convert --platform all $PACKAGE_PATH -o ./py34
for f in ./py34/**/$NAME*; do
    anaconda upload -u $ORG --force $f
done
rm -r ./py34

# Build 3.5
conda build --python 3.5 .
PACKAGE_PATH=`conda build --python 3.5 --output .`
conda convert --platform all $PACKAGE_PATH -o ./py35
for f in ./py35/**/$NAME*; do
    anaconda upload -u $ORG --force $f
done
rm -r ./py35

