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

# go to calculix source code folder
cd /calculix_src/

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
cd /calculix_src/spooles.2.2/
make lib

# compile arpak
cd /calculix_src/chaoyang2013-arpack-4b070f981380/
make lib

# compile calculix
cd /calculix_src/CalculiX/ccx_2.21/src/
make

# move calculix executable into bin folder
mv ccx_2.21 /usr/local/bin

# move to the run folder
cd /calculix_run/
