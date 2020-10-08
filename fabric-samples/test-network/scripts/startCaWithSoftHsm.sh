#!/bin/bash

# Init token
softhsm2-util --init-token --slot 0 --label "fabric" --so-pin 71811222 --pin 71811222 

# Start CA server
fabric-ca-server start -b admin:adminpw -d