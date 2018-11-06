# UGent Cluster


## Setup

SSH to a login node. Move to the golett cluster (we only use OpenMP, so no MPI support is needed):
```
module swap cluster/golett
```

Submit an interactive job (`-I`) to compile and test the code (here one node with twelve processors to test OpenMP performance).
```
qsub -I -l nodes=1:ppn=12
```


## Compiling gqcp and its dependencies

Load in the required modules
```
module purge
module load intel/2018a
module load Libint/2.4.2-intel-2018a
module load CMake/3.10.3-GCCcore-6.4.0
module load Eigen/3.3.4
module load Boost/1.66.0-intel-2018a
```

Make sure Eigen3 can be found (for a list of all available environment variables use `printenv`)
```
export EIGEN3_ROOT=$EBROOTEIGEN/include
```
and libint2 can be found
```
export LIBINTROOT=/apps/gent/CO7/haswell-ib/software/Libint/2.4.2-intel-2018a/
```


Set the install prefix to a local directory, e.g.:
```
export INSTALL_PREFIX=~/local
```


Clone the dependencies and run CMake, making sure that you use the intel compilers:
```
git clone https://github.com/GQCG/cpputil.git --branch develop --single-branch
(cd cpputil && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} && make && make test && make install)

git clone https://github.com/GQCG/numopt.git --branch develop --recurse-submodules
(cd numopt && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DUSE_MKL=ON && make && make test && make install)
```


Finally, clone and install gqcp
```
git clone https://github.com/GQCG/gqcp.git --branch develop --recurse-submodules
(cd gqcp && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} && make && make test && make install)
```

## Running the software (either interactively or through batch submission)

Load in the required modules
```
module purge && module load intel/2018a && module load Libint/2.4.2-intel-2018a && module load CMake/3.10.3-GCCcore-6.4.0 && module load Eigen/3.3.4 && module load Boost/1.66.0-intel-2018a
```

Run the software according to the details that can be found at [HPC UGent](https://www.ugent.be/hpc/en/support/documentation.htm). 

