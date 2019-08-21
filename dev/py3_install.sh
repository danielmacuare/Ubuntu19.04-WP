#!/bin/bash
# Teh following command is needed to expand aliases. Otherwise the aliases would not work
shopt -s expand_aliases

green_bold="\033[1;32;49m"
red_bold="\033[1;31;49m"
normal="\033[0m"

USER_DIR="/home/vagrant/"
VENV_NAME="venvs/py37"
PY3_VERSION="3.7.4"
APT_PACKS=(
        gcc
        openssl-devel
        bzip2-devel
        libffi-devel
)

# =================================================================== # Functions # ===================================================================
INST_PACK(){
for PCKGS in "$@"; do
        printf "$green_bold[INSTALLING]$normal - Packet: $red_bold$PCKGS$normal\n"
        sudo yum --quiet -y install $PCKGS > /dev/null 2>&1
        # printf "\n\n"

done
}


# =================================================================== # Initial setup for Py3.7 # ===================================================================
printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tINSTALLING REQUIRED PACKAGES FOR PYTHON $PY3_VERSION $normal\n"
printf "$normal############################################################################$normal\n"

INST_PACK "${APT_PACKS[@]}"
printf "\n\n"


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tDOWNLOADING AND EXTRACTING PYTHON $PY3_VERSION  $normal\n"
printf "$normal############################################################################$normal\n"

cd /usr/src
sudo wget https://www.python.org/ftp/python/$PY3_VERSION/Python-$PY3_VERSION.tgz
sudo tar zxf Python-$PY3_VERSION.tgz


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tINSTALLING PYTHON $PY3_VERSION  $normal\n"
printf "$normal############################################################################$normal\n"

cd Python-$PY3_VERSION
sudo ./configure --enable-optimizations
sudo make altinstall


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tINSTALLING VIRTUALENV  $normal\n"
printf "$normal############################################################################$normal\n"

echo "EXECUTING: pip3.7 install virtualenv --user"
pip3.7 install virtualenv --user > /dev/null 2>&1

echo "EXECUTING: virtualenv -p python3.7 $USER_DIR$VENV_NAME/"
virtualenv -p python3.7 $USER_DIR$VENV_NAME/ > /dev/null 2>&1


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tCREATING ALIASES  $normal\n"
printf "$normal############################################################################$normal\n"

echo "EXECUTING: alias pyen37='source $USER_DIR$VENV_NAME/bin/activate'"
echo "alias pyen37='source $USER_DIR$VENV_NAME/bin/activate'" >> /home/vagrant/.bashrc

echo "EXECUTING: alias python3='/usr/local/bin/python3.7'"
echo "alias python3='/usr/local/bin/python3.7'" >> /home/vagrant/.bashrc

echo "EXECUTING: source /home/vagrant/.bashrc"
source /home/vagrant/.bashrc


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tREMOVING UNNECESSARY FILES  $normal\n"
printf "$normal############################################################################$normal\n"

echo "EXECUTING: rm /usr/src/Python-$PY3_VERSION.tgz"
rm /usr/src/Python-$PY3_VERSION.tgz


printf "$normal\n\n############################################################################$normal\n"
printf "$normal\t\tINSTALLATION FINISHED  $normal\n"
printf "$normal############################################################################$normal\n"
