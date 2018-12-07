#!/usr/bin/env bash

# All source files are installed in ${VSC_DATA}/apps.
# Due to cluster specific optimizations, each supported cluster gets its own directory.
# The compiled binaries can be found under ${VSC_DATA}/apps/${VSC_INSTITUTE_CLUSTER}/gqcg/local

echo "Init compilation on victini."
module swap cluster/victini 2> /dev/null
qsub per_cluster_install.sh

echo "Init compilation on delcatty."
module swap cluster/delcatty 2> /dev/null
qsub per_cluster_install.sh


