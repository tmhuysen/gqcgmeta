#!/usr/bin/env bash

# All source files are installed in ${VSC_DATA}/apps.
# Due to cluster specific optimizations, each supported cluster gets its own directory.
# The compiled binaries can be found under ${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg/local

echo "Init compilation on golett."
module swap cluster/golett 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=12 -l mem=30gb

echo "Init compilation on swalot."
module swap cluster/golett 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=10 -l mem=30gb

echo "Init compilation on victini."
module swap cluster/victini 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=18 -l mem=44gb

echo "Init compilation on delcatty."
module swap cluster/delcatty 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=8 -l mem=30gb



