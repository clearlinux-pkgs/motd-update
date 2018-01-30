#!/bin/sh

if ! touch /run/motd.temp 2>/dev/null; then
	echo "ERROR: Permission denied. Try sudo" 1>&2
	exit 1
fi

rm -f /run/motd.temp

if [ -d /usr/lib/motd.d ]; then
	cat /usr/lib/motd.d/* > /run/motd.temp 2>/dev/null
fi

if [ -d /run/motd.d ]; then
	cat /run/motd.d/* >> /run/motd.temp 2>/dev/null
fi

if [ -d /etc/motd.d ]; then
	cat /etc/motd.d/* >> /run/motd.temp 2>/dev/null
fi

# Nothing to be done
if [ ! -e /run/motd.temp ]; then
    exit 0
fi

if mv -f /run/motd.temp /run/motd; then
	cat /run/motd
	exit 0
else
        echo "ERROR: could not install new MOTD" 1>&2
        exit 1
fi

