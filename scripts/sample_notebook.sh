#!/bin/bash

if [ ! -d /data/MLDL-demo ]; then
    cp -a /usr/local/samples/MLDL-demo /data/MLDL-demo
fi

exec /usr/local/bin/nimbix_notebook "$@"


