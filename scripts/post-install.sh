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

# Setup cluster users
sudo sh /fsx/.config/hpc-config/users/user-setup.sh


# Append to bashrc
sudo tee -a /home/ec2-user/.bashrc >/dev/null <<'EOF'

slurm_timer() {
    if [[ -n "$SLURM_JOB_END_TIME" && -n "$SLURM_JOB_START_TIME" ]]; then
        local t=$(( (SLURM_JOB_END_TIME - $(date +%s) + 30)/60 ))
        printf "(%dm) " "$t"
    fi
}
export PS1='$(slurm_timer)[${debian_chroot:+($debian_chroot)}\[\033[1;37m\]\u@\h\[\033[00m\] \[\033[1;90m\]\w\[\033[00m\]]\$ '
EOF