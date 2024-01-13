#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "用法: $0 <domain list file>"
    exit 1
fi

domain_list_file=$1

if [ ! -f "$domain_list_file" ]; then
    echo "Error: File Does Not exist."
    exit 1
fi

sed -i -e 's/\./\\\./g' -e 's/^/    \.\*/' -e 's/$/\$ \*/' $domain_list_file || (echo -e "[${red}Error:${plain}] Failed to configuration sniproxy." && exit 1)
sed -i -e "/table {/,/}/c\table {\n$(sed 's/\\/\\\\/g;s/$/\\/' "$domain_list_file")}" "/etc/sniproxy.conf"
#sed -i -e "/table {/,/}/c\table {\n$(sed 's/$/\\/' "$domain_list_file")}" "/etc/sniproxy.conf"
systemctl restart sniproxy.service
