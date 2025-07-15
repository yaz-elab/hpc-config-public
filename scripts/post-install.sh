#!/bin/bash
# POST INSTALL SCRIPT
# This script is executed after the deployment of the HPC configuration.

# Add modules
sh /fsx/software/.config/setup/add-to-profile.d.sh
