#!/usr/bin/bash

# Load all GQCP modules
echo "Loading all GQCP modules..."
module purge
module load intel/2018a
module load Libint/2.4.2-intel-2018a
module load CMake/3.10.3-GCCcore-6.4.0
module load Eigen/3.3.4
module load Boost/1.66.0-intel-2018a


# Make sure Eigen3 and Libint2 can be found
export EIGEN3_ROOT=${EBROOTEIGEN}/include
export LIBINTROOT=/apps/gent/CO7/haswell-ib/software/Libint/2.4.2-intel-2018a/


echo "Done."
