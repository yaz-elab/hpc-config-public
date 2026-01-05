#!/bin/bash
# POST INSTALL SCRIPT
# This script is executed after the deployment of the HPC configuration.

# install software
sudo yum install -y \
    environment-modules \
    htop \
    gnuplot
    
# Add link to .modulesfiles
sh /fsx/software/.modulefiles/.setup/add-to-profile.d.sh

# Add custom settings and tools
sudo ln -sf /fsx/.config/hpc-config/profile.d/*.sh /etc/profile.d/

# Modify headnode settings
cat << 'EOF' >> ~/.bashrc

# Custom coloured prompt
# PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\$ '
PS1='[${debian_chroot:+($debian_chroot)}\[\033[1;37m\]\u@\h\[\033[00m\] \[\033[1;90m\]\w\[\033[00m\]]\$ '

EOF

# # # Install additional dependencies for paraview
# sudo dnf install -y \
#      xcb-util-cursor \
#      libxcrypt-compat \
#      libxkbcommon xcb-util xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm

# # # Compilation dependencies for openfoam
# # sudo dnf install clang -y

