#!/bin/bash

#This is a common library created for the ok & fatal function 
#and symlinks added to the data/ in each directory

ok() {
    echo "ok" "$@"
}

fatal() {
    echo "$@" >&2
    exit 1
}

get_ip_for_nic () {
    local nic_name=$1
    nic_ip=""
    nic_ip=`ip -j addr show ${nic_name} | jq -r '.[0].addr_info | map(select(.family == "inet")) | .[0].local'`
    if [ -z "$nic_ip" ]; then
        echo "Error: can not get ${nic_name} ip"
        exit 1
    fi
}