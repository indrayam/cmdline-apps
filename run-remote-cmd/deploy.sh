#!/bin/bash

function upload_to_sandbox {
    hostname1="dftapp@dft-webapps-sb-1.cisco.com"
    hostname2="dftapp@dft-webapps-sb-2.cisco.com"
    scp -q $filename $hostname1:/tmp
    ssh -T $hostname1 <<EOF
    hostname
    cat /tmp/test.txt
    rm /tmp/test.txt
    ls /tmp/test.txt
EOF
    scp -q $filename $hostname2:/tmp
    ssh -T $hostname2 <<EOF
    hostname
    cat /tmp/test.txt
    rm /tmp/test.txt
    ls /tmp/test.txt
EOF
}

function upload_to_stage {
    echo "You are processing the logic for environment: $env"
}

function upload_to_prod {
    echo "You are processing the logic for environment: $env"
}


if [ $# -eq 1 ]; then
    env=$1
    filename="test.txt"
    if [ "$env" = "sb" ]; then
        upload_to_sandbox
    elif [[ "$env" = "stg" ]]; then
        upload_to_stage
    elif [[ "$env" = "prd" ]]; then
        upload_to_prod
    fi
else
    echo "Usage: deploy.sh sb|stg|prod"
fi