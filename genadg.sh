#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Useage: $0 <domain list file> <SNIProxy Target IP>"
    exit 1
fi

domain_list_file=$1
ip_address=$2

if [ ! -f "$domain_list_file" ]; then
    echo "Error: File Does Not exist"
    exit 1
fi

while IFS= read -r domain; do
    if [ -n "$domain" ]; then
        echo "||${domain}^\$dnsrewrite=${ip_address}"
    fi
done < "$domain_list_file"
