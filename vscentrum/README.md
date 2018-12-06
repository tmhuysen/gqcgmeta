# VSCentrum

## General information

Information on how to access and use the HPC infrastructure can be found at [HPC UGent](https://www.ugent.be/hpc/en/support/documentation.htm). 

## Build instructions

Clone this repository to a directory of your choosing.

```
git clone https://github.com/GQCG/gqcgmeta.git
```

Run the `install.sh' script
```
chmod u+x install.sh
./install.sh
```

This will download all relevant GQCG codes and will launch compilation submissions on all supported clusters. After these jobs have finished, you can find the compiled code at `${VSC_DATA}/apps/${CLUSTER}/gqcg/local'.

Note that the default checked out branch is develop. If needed, you can adjust the checked out branches in the `per_cluster_install.sh'.

