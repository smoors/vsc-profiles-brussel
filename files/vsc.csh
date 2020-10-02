eval `/usr/bin/vsc_env csh`

if (! $?VSC_OS_LOCAL) then
setenv VSC_OS_LOCAL CO7
endif

if (! $?VSC_ARCH_LOCAL) then

    if ( { grep -q 'CPU.E5-2680.v2' /proc/cpuinfo } ) then
      setenv VSC_ARCH_LOCAL ivybridge
      setenv VSC_ARCH_SUFFIX -ib
    else if ( { grep -q 'CPU.E5-[0-9]\+.v3' /proc/cpuinfo } ) then
      setenv VSC_ARCH_LOCAL haswell
      setenv VSC_ARCH_SUFFIX -ib
    else if ( { grep -q 'CPU.E[57]-[0-9]\+.v4' /proc/cpuinfo } ) then
      setenv VSC_ARCH_LOCAL broadwell
      setenv VSC_ARCH_SUFFIX ''
    else if ( { grep -q 'Gold \(6148\|6126\)' /proc/cpuinfo } ) then
      setenv VSC_ARCH_LOCAL skylake
      setenv VSC_ARCH_SUFFIX ''
    else
      setenv VSC_ARCH_LOCAL ''
      setenv VSC_ARCH_SUFFIX ''
    endif
endif

setenv LMOD_SYSTEM_NAME "${VSC_INSTITUTE_CLUSTER}-${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}"

setenv HYDRA_MODULEPATH ""
set i = 2016
while ($i < 2025)
  if ( -d  /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}a/all ) then
    setenv HYDRA_MODULEPATH /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}a/all:${HYDRA_MODULEPATH}
  endif
  if ( -d  /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}b/all ) then
    setenv HYDRA_MODULEPATH /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}b/all:${HYDRA_MODULEPATH}
  endif
  @ i++
end

setenv MODULEPATH ${HYDRA_MODULEPATH}:/etc/modulefiles/vsc
unset HYDRA_MODULEPATH

# vim: set ft=csh:
