# UGent Cluster

## Setup

SSH to a login node. Move to the golett cluster (we will only use OpenMP; no MPI support needed).
```
module swap cluster/golett
```

Submit an interactive job to compile and test the code (here one node with twelve processors to test OpenMP performance).
```
qsub -I -l nodes=1:ppn=12
```

## Compilation

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

Set the install prefix to a local directory. E.g.:
```
INSTALL_PREFIX=~/local
```

Clone the necessary repositories and run CMake, making sure that you use the intel compilers. E.g.:
```
git clone https://github.com/GQCG/cpputil.git --branch develop --single-branch
(cd cpputil && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX && make && make test && make install)

git clone https://github.com/GQCG/numopt.git --recurse-submodules
(cd numopt && rm -rf build && mkdir build && cd build && cmake .. -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_INSTALL_PREFIX=~/local -DUSE_MKL=ON && make && make install)
```

## Running the software (either interactively or through batch submission)

Load in the required modules
```
module purge
module load intel/2018a
```

Run the software according to the details that can be found at [HPC UGent](https://www.ugent.be/hpc/en/support/documentation.htm). 

