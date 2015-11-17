#!/bin/sh

if ! touch /run/motd.temp 2>/dev/null; then
	echo "Permission denied. Try sudo" 1>&2;
	exit 1;
fi

rm -rf /run/motd.temp 2>/dev/null;

if [ -d /usr/lib/motd.d ]; then
	cat /usr/lib/motd.d/* > /run/motd.temp 2>/dev/null;
fi

if [ -d /etc/motd.d ]; then
	cat /etc/motd.d/* >> /run/motd.temp 2>/dev/null;
fi

if mv -f /run/motd.temp /run/motd; then
	cat /run/motd.temp
	exit 0
else
        echo "ERROR: could not install new MOTD" 1>&2
        exit 1
fi

