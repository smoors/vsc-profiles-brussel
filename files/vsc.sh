eval $(/usr/bin/vsc_env bash)

if [ -z "$VSC_OS_LOCAL" ]; then
    export VSC_OS_LOCAL=CO7
fi

if [ -z "$VSC_ARCH_LOCAL" ]; then
    if grep -q 'CPU.E[0-9]\+-[0-9]\+L\?.v2' /proc/cpuinfo
      then
      export VSC_ARCH_LOCAL=ivybridge
      export VSC_ARCH_SUFFIX=-ib
    elif grep -q 'CPU.E[0-9]\+-[0-9]\+L\?.v3' /proc/cpuinfo
      then
      export VSC_ARCH_LOCAL=haswell
      export VSC_ARCH_SUFFIX=-ib
    elif grep -q 'CPU.E[0-9]\+-[0-9]\+L\?.v4' /proc/cpuinfo
      then
      export VSC_ARCH_LOCAL=broadwell
      export VSC_ARCH_SUFFIX=''
    elif grep -q 'Gold [56]1[0-9][0-9]' /proc/cpuinfo
      then
      export VSC_ARCH_LOCAL=skylake
      export VSC_ARCH_SUFFIX=''
    else
      export VSC_ARCH_LOCAL=''
      export VSC_ARCH_SUFFIX=''
    fi
fi

export LMOD_SYSTEM_NAME="${VSC_INSTITUTE_CLUSTER}-${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX:-}"

HYDRA_MODULEPATH=
for i in {2016..2025}; do
  if [ -d /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX:-}/modules/${i}a/all ]; then
    HYDRA_MODULEPATH=/apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX:-}/modules/${i}a/all:$HYDRA_MODULEPATH
  fi
  if [ -d /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX:-}/modules/${i}b/all ]; then
    HYDRA_MODULEPATH=/apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX:-}/modules/${i}b/all:$HYDRA_MODULEPATH
  fi
done

export MODULEPATH=$HYDRA_MODULEPATH:/etc/modulefiles/vsc

unset HYDRA_MODULEPATH

# vim: set ft=sh:
