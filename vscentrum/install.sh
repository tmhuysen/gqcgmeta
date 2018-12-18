#!/usr/bin/env bash

# All source files are installed in ${VSC_DATA}/apps.
# Due to cluster specific optimizations, each supported cluster gets its own directory.
# The compiled binaries can be found under ${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg/gqcp/bin

echo "Init compilation on golett."
module swap cluster/golett 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=12 -l mem=30gb

echo "Init compilation on swalot."
module swap cluster/golett 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=10 -l mem=30gb

echo "Init compilation on phanpy."
module swap cluster/phanpy 2> /dev/null
qsub per_cluster_install.sh -l nodes=1:ppn=12 -l mem=30gb



