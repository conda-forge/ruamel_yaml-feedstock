#!/bin/bash -eu

env | sort
RECIPE_DIR=${1-$RECIPE_DIR}
SRC_DIR=${2-$SRC_DIR}

VERSION=$(cd $SRC_DIR && python setup.py --version)
echo "VERSION=$VERSION"

rm -f $SRC_DIR/setup.py

mkdir $SRC_DIR/ruamel_yaml
mv $SRC_DIR/*.py $SRC_DIR/ruamel_yaml/

sed -i -e 's/ruamel\.yaml/ruamel_yaml/g' $(find $SRC_DIR/. -name \*.py -type f)
Renive
cp $RECIPE_DIR/setup.py $SRC_DIR/
cp $RECIPE_DIR/__init__.py $SRC_DIR/ruamel_yaml/
sed -i -e "s/"'"'"\$VERSION"'"'"/"'"'"${VERSION}"'"'"/" $SRC_DIR/ruamel_yaml/__init__.py
