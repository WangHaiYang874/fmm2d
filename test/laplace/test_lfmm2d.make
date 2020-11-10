PROJECT = int2-lfmm2d

HOST = gcc
HOST = gcc-openmp

# FC - fortran compiler
# FFLAGS - fortran compiler flags

ifeq ($(HOST),gcc)
    FC=gfortran 
    FFLAGS=-fPIC -O3 -funroll-loops -march=native -std=legacy 
endif

ifeq ($(HOST),gcc-openmp)
    FC = gfortran 
    FFLAGS=-fPIC -O3 -funroll-loops -march=native -fopenmp -std=legacy
endif

# Test objects
#

LFMM = ../../src/laplace
COM = ../../src/common


.PHONY: all clean list


OBJECTS =  test_lfmm2d.o \
  $(COM)/prini_new.o \
  $(COM)/hkrand.o \
  $(COM)/dlaran.o \
  $(COM)/pts_tree2d.o \
  $(COM)/tree_routs.o \
  $(COM)/cumsum.o \
  $(LFMM)/lfmm2d.o \
  $(LFMM)/lfmm2dwrap.o \
  $(LFMM)/lfmm2dwrap_vec.o \
  $(COM)/fmmcommon2d.o \
  $(LFMM)/laprouts2d.o \
  $(LFMM)/lapkernels2d.o \
  $(LFMM)/l2dterms.o 


#

%.o : %.f %.h
	$(FC) $(FFLAGS) $< -o $@

all: $(OBJECTS)
	rm -f $(PROJECT)
	$(FC) $(FFLAGS) -o $(PROJECT) $(OBJECTS)
	./$(PROJECT)

clean:
	rm -f $(OBJECTS)
	rm -f $(PROJECT)

list: $(SOURCES)
	$(warning Requires:  $^)





  
