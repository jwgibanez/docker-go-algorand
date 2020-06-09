#!/usr/bin/env bash

cp -p /docker/config.json /node/data/config.json
cp -p /docker/kmd_config.json /node/data/kmd-v0.5/kmd_config.json

goal node start
carpenter -D
goal node stop
