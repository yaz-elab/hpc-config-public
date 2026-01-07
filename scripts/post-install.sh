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

# Modify teminal display style
cat << 'EOF' >> ~/.bashrc

# Custom coloured prompt
# PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\$ '
# PS1='[${debian_chroot:+($debian_chroot)}\[\033[1;37m\]\u@\h\[\033[00m\] \[\033[1;90m\]\w\[\033[00m\]]\$ '
PS1='$( 
    if [[ -n "$SLURM_JOB_END_TIME" && -n "$SLURM_JOB_START_TIME" ]]; then
        t=$(( (SLURM_JOB_END_TIME - $(date +%s) + 30)/60 ))
        printf "(%dm) " "$t"
    fi
)[${debian_chroot:+($debian_chroot)}\[\033[1;37m\]\u@\h\[\033[00m\] \[\033[1;90m\]\w\[\033[00m\]]\$ '

EOF

# # Compilation dependencies for openfoam
# sudo dnf install clang -y

