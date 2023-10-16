#!/bin/bash

name=linuzilla/vlmcsd
version_number=1.0


patchlevel=$(docker images ${name} | sed 1d | awk '{ print $2 }' | grep "${version_number}." | sort -V -r | sed -E "s/^${version_number}\.//" | head -1)

if [ "$patchlevel" = "" ]; then
	patchlevel="0"
else
	patchlevel=$(( patchlevel + 1 )) 
fi

echo docker build . -t ${name}:${version_number}.${patchlevel}
docker build . -t ${name}:${version_number}.${patchlevel}
