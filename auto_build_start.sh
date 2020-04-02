#!/bin/bash

# This is a helper file purely for local development. Not related to the build process
sudo docker build -t dns-tor .
sudo docker run -it --rm -p 53:54 dns-tor