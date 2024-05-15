bzip2 -dk ccx_2.21.src.tar.bz2
tar -xvf ccx_2.21.src.tar

mkdir spooles.2.2
tar -xzvf spooles.2.2.tgz -C spooles.2.2
unzip -l chaoyang2013-arpack-4b070f981380

cp -fv Make.inc_ spooles.2.2/Make.inc
cp -fv ARmake.inc_ chaoyang2013-arpack-4b070f981380/ARmake.inc
cp -fv makefile_ CalculiX/ccx_2.21/src/makefile

cd(/calculix_src/spooles.2.2/)
make lib

cd(/calculix_src/chaoyang2013-arpack-4b070f981380/)
make lib

cd(/calculix_src/CalculiX/ccx_2.21/src/)
make

mv ccx_2.21 /usr/local/bin

cd(/calculix_run/)
