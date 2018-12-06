#!/usr/bin/bash

# Load all GQCP modules
module purge
module load intel/2018a
module load Libint/2.4.2-intel-2018a
module load CMake/3.10.3-GCCcore-6.4.0
module load Eigen/3.3.4
module load Boost/1.66.0-intel-2018a

# Configure packages
export EIGEN3_ROOT=${EBROOTEIGEN}/include
export LIBINTROOT=/apps/gent/CO7/haswell-ib/software/Libint/2.4.2-intel-2018a/

case ${VSC_INSTITUTE_CLUSTER} in
    "delcatty" )
	LIBINT_ROOT=/apps/gent/CO7/haswell-ib/software/Libint/2.4.2-intel-2018a
	;;
    "victini" )
        LIBINT_ROOT=/apps/gent/CO7/skylake-ib/software/Libint/2.4.2-intel-2018a
	;;
    * )
	echo "ERROR: Only the delcatty and victini clusters are supported."
	exit 1
	;;
esac

export LIBINT_DATA_PATH=${LIBINT_ROOT}/share/libint/2.4.2/basis

