# example .bash_profile script

umask 077

for path in /usr/kerberos/bin /usr/local/bin /usr/sww/bin /usr/sfw/bin
do
  if [ -e $path ]; then
        export PATH=${PATH}:$path
  fi
done

# If shell is interactive, then source the .bashrc
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

####################################
# SERVER Specific Configuration
####################################

# Quick way to get home
export SCRATCH_HOME=/scratch/abejgonza

# Quickly call the vlsi script for the tools
source /ecad/tools/vlsi.bashrc
export VCS_LIC_EXPIRE_WARNING=0

# RISCV Items
export RISCV=$SCRATCH_HOME/bin/riscv-tools-install
export PATH=$RISCV/bin:$PATH
export LD_LIBRARY_PATH=$RISCV/lib

# Add local bins
export PATH=$SCRATCH_HOME/bin:$PATH

# Set SBT to cache locally
# Call created script in $SCRATCH_HOME/bin
export SBT=sbt

export CONFIG_DIR=$SCRATCH_HOME/config

# Source location agnostic bash
source $CONFIG_DIR/.bash_common
