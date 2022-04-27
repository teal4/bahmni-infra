#!/bin/bash

set -e
REL_SCRIPT_DIR="`dirname \"$0\"`"
SCRIPT_DIR="`( cd \"$REL_SCRIPT_DIR\" && pwd)`"
# sourcing git hub actions common script
source $SCRIPT_DIR/../.github/gha_common.sh

run_scan(){
    folder=$1

    cd $folder
    terraform_init

    echo -e "${GREEN_COLOR}TFSec Scanning $folder....$NO_COLOR"
    tfsec --config-file $SCRIPT_DIR/tfsec.yml --tfvars-file=terraform.tfvars --verbose

    cd - > /dev/null
    echo -e "\n"
}

run_scan terraform/shared
for folder in terraform/environment/*
do
    run_scan $folder
done;
