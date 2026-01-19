#!/bin/bash
# POST INSTALL SCRIPT
# This script is executed after the deployment of the HPC configuration.

# install software
sudo yum install -y \
    environment-modules \
    htop \
    gnuplot

# Install additional dependencies for paraview support
sudo dnf install -y \
     xcb-util-cursor \
     libxcrypt-compat libxkbcommon \
     xcb-util xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm \
     mesa-libOSMesa mesa-libOSMesa-devel \
     libXcursor libXcursor-devel

# Add link to .modulesfiles
sh /fsx/software/.modulefiles/.setup/add-to-profile.d.sh

# Add custom settings and tools
sudo ln -sf /fsx/.config/hpc-config/profile.d/*.sh /etc/profile.d/

# # Compilation dependencies for openfoam
# sudo dnf install clang -y

