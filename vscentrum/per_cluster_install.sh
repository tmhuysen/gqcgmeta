#!/usr/bin/env bash

PPN=3

#PBS -l nodes=1:ppn=${PPN}
#PBS -N gqcg_compilation_on_${VSC_INSTITUTE_CLUSTER}
#PBS -l mem=12gb

module purge
module load intel/2018a
module load Libint/2.4.2-intel-2018a
module load CMake/3.10.3-GCCcore-6.4.0
module load Eigen/3.3.4
module load Boost/1.66.0-intel-2018a

export EIGEN3_ROOT=$EBROOTEIGEN/include

SOURCE_PREFIX=${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg
INSTALL_PREFIX=${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg/local

rm -rf ${SOURCE_PREFIX} && mkdir -p ${SOURCE_PREFIX} && cd ${SOURCE_PREFIX}

# 1. cpputil
rm -rf cpputil
git clone https://github.com/GQCG/cpputil.git --branch develop
(cd cpputil && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} && make -j ${PPN} && make test ARGS=-j${PPN} && make install)

# 2. numopt
rm -rf numopt
git clone https://github.com/GQCG/numopt.git --branch develop --recurse-submodules
(cd numopt && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DUSE_MKL=ON && make -j ${PPN} && make test ARGS=-j${PPN} && make install)

# 3.
rm -rf gqcp
git clone https://github.com/GQCG/gqcp.git --branch develop
(cd gqcp && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DLIBINTROOT=/apps/gent/CO7/haswell-ib/software/Libint/2.4.2-intel-2018a -DUSE_MKL=ON && make -j ${PPN} && make test ARGS=-j${PPN} && make install)
