
CFLAGS = -O2  -I /calculix_src/spooles.2.2 -DARCH="Linux" -DSPOOLES -DARPACK -DMATRIXSTORAGE -DNETWORKOUT -Wno-implicit-function-declaration
FFLAGS = -O2

CC=cc
FC=gfortran

.c.o :
	$(CC) $(CFLAGS) -c $<
.f.o :
	$(FC) $(FFLAGS) -c $<

include Makefile.inc

SCCXMAIN = ccx_2.21.c

OCCXF = $(SCCXF:.f=.o)
OCCXC = $(SCCXC:.c=.o)
OCCXMAIN = $(SCCXMAIN:.c=.o)

DIR = /calculix_src/spooles.2.2

LIBS = \
       $(DIR)/spooles.a \
	/calculix_src/chaoyang2013-arpack-4b070f981380/libarpack_Cori.a \
       -lpthread -lm -lc -llapack -lblas

ccx_2.21: $(OCCXMAIN) ccx_2.21.a  $(LIBS)
	./date.pl; $(CC) $(CFLAGS) -c ccx_2.21.c; $(FC) -O2 -o $@ $(OCCXMAIN) ccx_2.21.a $(LIBS) -fopenmp

ccx_2.21.a: $(OCCXF) $(OCCXC)
	ar vr $@ $?
