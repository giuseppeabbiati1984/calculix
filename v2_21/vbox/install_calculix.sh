#!/bin/bash

# exit script on error
set -e

# check if the executable is already available
if [ -f "/usr/local/bin/ccx_2.21" ]; then
	echo "Calculix 2.21 is already installed."
	exit 0
else
	echo "Calculix 2.21 compiling starts."
fi

apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update && apt-get upgrade -y && apt-get update
apt-get install -y gcc gfortran bash make nano bzip2 libblas-dev liblapack-dev liblapacke-dev nano unzip xfce4 xfce4-goodies xfce4-terminal tightvncserver doxygen python3 python3-pip

# decompress archives for calculix source code
rm -f ccx_2.21.src.tar
bzip2 -dk ccx_2.21.src.tar.bz2
tar -xvf ccx_2.21.src.tar

# decompress archives for spools source code
rm -rf spooles.2.2
mkdir spooles.2.2
tar -xzvf spooles.2.2.tgz -C spooles.2.2

# decompress archive for arpack source code
rm -rf chaoyang2013-arpack-4b070f981380
unzip chaoyang2013-arpack-4b070f981380

# replace make files with the customized ones
cp -fv Make.inc_ spooles.2.2/Make.inc
cp -fv ARmake.inc_ chaoyang2013-arpack-4b070f981380/ARmake.inc
cp -fv makefile_ CalculiX/ccx_2.21/src/makefile

# compile spools
cd spooles.2.2/
make lib
cd ..

# compile arpak
cd chaoyang2013-arpack-4b070f981380/
make lib
cd ..

# compile calculix
cd CalculiX/ccx_2.21/src/
make
cd ..

# move calculix executable into bin folder
mv ccx_2.21 /usr/local/bin