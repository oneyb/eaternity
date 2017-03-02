# In my .bashrc
function get-bash-functions-for-bw2 ()
{
    source /d/documents/eaternity/eaternity/eaternity-brightway-functions.bash
}

xdotool type "io-bw2"

function io-bw2 ()
{
    dir=/d/documents/eaternity/eaternity/
    if [ -z $(which conda) ]; then
        cd $dir
        xdotool type "jupyter-notebook --notebook-dir=$dir --browser=firefox"
        flip-bw2-virtualenv-conda
    else
        flip-bw2-virtualenv-conda
        cd ~
    fi
}

function flip-bw2-virtualenv-conda ()
{
    dir=/d/documents/eaternity/bw2-py
    cd $dir
    if [ -z $(which conda) ]; then
        echo activating
        export PATH="$dir/bin:$PATH"
        source activate bw2
        PROMPT_COMMAND='echo -ne "\033]0;Brightway2\007"'
    else
        echo deactivating
        source deactivate
        PROMPT_COMMAND='echo -ne "\033]0;Terminal\007"'
        export PATH=$(echo $PATH | sed -r 's/^[^:]+://g')
    fi
    cd -
}

# from: https://docs.brightwaylca.org/advanced-installation.html
# for python 3 on debian jessy
function install-conda()
{
    dir=/d/documents/eaternity/bw2-py
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
    echo $dir
    conda install -q -y conda && conda update -q conda
}

function install-brightway-dev-plus-deps-with-conda ()
{
    if [[ $# -eq 0 ]]; then
        dir=/d/documents/eaternity/bw2-py
    else
        dir=$1
    fi
    if [ -f $dir ]; then
        cd $dir
    else
        mkdir -p $dir
    fi

    conda config --system --add channels conda-forge
    conda create -y -n bw2 python=3.5

    source activate bw2
    cd -

    conda install wheel && conda update -q pip wheel setuptools
    conda install -q -y -c haasad pypardiso
    conda install -q -y ipython ipython-notebook jupyter matplotlib flask lxml \
          requests nose docopt whoosh xlsxwriter xlrd unidecode appdirs future \
          psutil unicodecsv wrapt numpy
    pip install --no-cache-dir brightway2
    conda clean -tipsy
    # Activity browser
    conda install networkx seaborn matplotlib
    pip install https://bitbucket.org/cmutel/activity-browser/get/2.0.zip
    if [[ $2 = "dev" ]]; then
        pip install -e hg+https://bitbucket.org/cmutel/brightway2-data#egg=bw2data
        pip install -e hg+https://bitbucket.org/cmutel/brightway2-calc#egg=bw2calc
        pip install -e hg+https://bitbucket.org/cmutel/brightway2-ui#egg=bw2ui
        pip install -e hg+https://bitbucket.org/cmutel/brightway2-analyzer#egg=bw2analyzer
    # else
    #     pip install bw2data bw2calc bw2ui bw2analyzer
    fi

    # Finish
    deactivate
    cd -
}

# from: https://docs.brightwaylca.org/advanced-installation.html#linux
# for python 3 on debian jessy
function install-brightway-dev-plus-deps-on-debian ()
{
    if [[ $# -eq 0 ]]; then
        dir=/d/documents/eaternity/bw2
    else
        dir=$1
    fi

    cd $(dirname $dir)
    mkvirtualenv --python=$(which python3) $dir

    source $dir/bin/activate
    if [ -z "$(toggleglobalsitepackages | grep Enable)" ]; then
        toggleglobalsitepackages
    fi

    pip3 install -U wheel setuptools notebook jupyter numpy
    pip3 install eight bw2speedups scikit-umfpack


    if [[ $2 = "dev" ]]; then
        pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-data#egg=bw2data
        pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-calc#egg=bw2calc
        pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-ui#egg=bw2ui
        pip3 install -e hg+https://bitbucket.org/cmutel/brightway2-analyzer#egg=bw2analyzer
    else
        pip3 install bw2data bw2calc bw2ui bw2analyzer
    fi

    # Finish
    deactivate
    cd -
}

function uninstall-brightway-dev-plus-deps ()
{
    if [[ $# -eq 0 ]]; then
        dir=bw2
    else
        dir=$1
    fi

    mkvirtualenv --python=$(which python3) $dir

    source $dir/bin/activate

    if [ -z "$(toggleglobalsitepackages | grep En)" ]; then
        toggleglobalsitepackages
    fi

    pip3 uninstall setuptools notebook jupyter eight bw2speedups numpy \
         scikit-umfpack brightway2

    pip3 uninstall bw2data bw2calc bw2ui bw2analyzer
    # Finish
    xdotool type deactivate
}

# a handy function:
function turn-on-bw2-virtualenv ()
{
    dir=/d/documents/eaternity/bw2
    if [  -z "$_OLD_VIRTUAL_PATH" ]; then
        echo activating
        source $dir/bin/activate
        PROMPT_COMMAND='echo -ne "\033]0;Brightway2\007"'
    else
        echo deactivating
        deactivate
        PROMPT_COMMAND='echo -ne "\033]0;Terminal\007"'
    fi
    echo "Restart emacs daemon?"
    xdotool type red
}

function install-deps-of-brightway ()
{
    sudo apt-get update
    sudo apt-get install python3-scipy python3-numpy python3-nose python3-pip     \
         python3-lxml cython python3-virtualenv virtualenvwrapper build-essential \
         libsuitesparse-dev swig mercurial
}

