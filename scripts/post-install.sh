#!/bin/bash
# POST INSTALL SCRIPT
# This script is executed after the deployment of the HPC configuration.

# Add modules
sh /fsx/software/.modulefiles/.setup/add-to-profile.d.sh

# install software
sudo yum install -y \
    htop

# # Compilation dependencies
# # for openfoam
# sudo dnf install clang -y