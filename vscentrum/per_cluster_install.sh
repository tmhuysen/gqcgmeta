#!/usr/bin/env bash

module purge
module load intel/2018a
module load Libint/2.4.2-intel-2018a
module load CMake/3.10.3-GCCcore-6.4.0
module load Eigen/3.3.4
module load Boost/1.66.0-intel-2018a

case ${VSC_INSTITUTE_CLUSTER} in
    "golett" )
	PPN=12
	MEM=30gb
	;;
    "swalot" )
	PPN=10
	MEM=30gb
	;;
    "phanpy" )
	PPN=12
	MEM=30gb
	;;
    # "delcatty" )
    # 	export LIBINT_ROOT=/apps/gent/CO7/sandybridge/software/Libint/2.4.2-intel-2018a
    # 	PPN=8
    # 	MEM=30gb
    # 	;;
    # "victini" )
    #     export LIBINT_ROOT=/apps/gent/CO7/skylake-ib/software/Libint/2.4.2-intel-2018a
    # 	PPN=18
    # 	MEM=30gb
    # 	;;
    * )
	echo "ERROR: Only the golett, swalot and phanpy clusters are supported."
	exit 1
	;;
esac

export EIGEN3_ROOT=$EBROOTEIGEN/include
export LIBINT_DATA_PATH=${EBROOTLIBINT}/share/libint/2.4.2/basis

SOURCE_PREFIX=${VSC_SCRATCH}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg
INSTALL_PREFIX=${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg

rm -rf ${INSTALL_PREFIX} && mkdir -p ${INSTALL_PREFIX}
rm -rf ${SOURCE_PREFIX} && mkdir -p ${SOURCE_PREFIX} && cd ${SOURCE_PREFIX}

# # 0. Google benchmark
#git clone https://github.com/tmhuysen/benchmark.git
#(cd benchmark && git clone https://github.com/google/googletest.git && mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} && make -j ${PPN} && make install)

# # 1. cpputil
# git clone https://github.com/GQCG/cpputil.git --branch develop
# (cd cpputil && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} && make -j ${PPN} && make test ARGS=-j${PPN} && make install)

# # 2. numopt
# git clone https://github.com/GQCG/numopt.git --branch develop --recurse-submodules
# (cd numopt && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DUSE_MKL=ON && make -j ${PPN} && make test ARGS=-j${PPN} && make install)

# 3. gqcp
git clone https://github.com/GQCG/gqcp.git --branch develop --recurse-submodules
(cd gqcp && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DLIBINTROOT=${EBROOTLIBINT} -DUSE_MKL=ON && make VERBOSE=1 -j ${PPN} && make test ARGS=-j${PPN} && make install)
