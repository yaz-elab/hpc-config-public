#!/bin/bash
# POST INSTALL SCRIPT
# This script is executed after the deployment of the HPC configuration.

# Install modules add link to .modulesfiles
sudo yum install environment-modules -y
sh /fsx/software/.modulefiles/.setup/add-to-profile.d.sh

# install software
sudo yum install -y \
    htop \
    gnuplot
    
# Install additional dependencies for paraview
sudo dnf install -y xcb-util-cursor
sudo dnf install -y libxcrypt-compat
sudo dnf install -y libxkbcommon xcb-util xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm

# Add custom settings and tools
sudo ln -sf /fsx/.config/hpc-config/profile.d/*.sh /etc/profile.d/

# # Compilation dependencies for openfoam
# sudo dnf install clang -y
