#!/usr/bin/env bash

if ! type linode &> /dev/null; then
	echo "The Linode CLI doesn't appear to be installed. Exiting."
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "You didn't specify a domain name"
	exit 1
fi

# Delete old records
until linode domain -a record-list -l $1 -t MX | grep "No records to list."; do
	linode domain -a record-delete -l $1 -t MX -m ""
done

# Set new Google Apps records
linode domain -a record-create -l $1 -t MX -R ASPMX.L.GOOGLE.COM -P 1
linode domain -a record-create -l $1 -t MX -R ALT1.ASPMX.L.GOOGLE.COM -P 5
linode domain -a record-create -l $1 -t MX -R ALT2.ASPMX.L.GOOGLE.COM -P 5
linode domain -a record-create -l $1 -t MX -R ALT3.ASPMX.L.GOOGLE.COM -P 10
linode domain -a record-create -l $1 -t MX -R ALT4.ASPMX.L.GOOGLE.COM -P 10
