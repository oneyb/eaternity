#!/usr/bin/env bash -x

# sudo apt-get update
# sudo apt-get install python3-scipy python3-numpy python3-nose        \
#      python3-pip python3-lxml cython python3-virtualenv virtualenvwrapper \
#      build-essential libsuitesparse-dev swig

# su $USER
if [[ $# -eq 0 ]]; then
    dir=bw2
else
    dir=$1
fi

virtualenv --python=$(which python3) $dir

source $dir/bin/activate

toggleglobalsitepackages

pip3 install -U wheel setuptools
pip3 install eight bw2speedups scikit-umfpack
pip3 install --user brightway2

pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-data#egg=bw2data
pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-calc#egg=bw2calc
pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-ui#egg=bw2ui
pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-analyzer#egg=bw2analyzer

# Finish
deactivate
