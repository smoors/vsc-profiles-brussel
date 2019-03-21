if (! $?VSC_INSTITUTE_CLUSTER) then
setenv VSC_INSTITUTE_CLUSTER hydra
endif

if (! $?VSC_OS_LOCAL) then
setenv VSC_OS_LOCAL CO7
endif

setenv VSC_ARCH_LOCAL ''
setenv VSC_ARCH_SUFFIX ''

if ( { grep -q 'Processor.2378' /proc/cpuinfo } ) then
  setenv VSC_ARCH_LOCAL shanghai
  setenv VSC_ARCH_SUFFIX -ib
else if ( { grep -q 'Processor.6134' /proc/cpuinfo } ) then
  setenv VSC_ARCH_LOCAL magnycours
  setenv VSC_ARCH_SUFFIX -ib
else if ( { grep -q 'Processor.6274' /proc/cpuinfo } ) then
  setenv VSC_ARCH_LOCAL interlagos
  setenv VSC_ARCH_SUFFIX -ib
else if ( { grep -q 'CPU.E5-2680.v2' /proc/cpuinfo } ) then
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
endif

setenv HYDRA_EB_ALL ""
set i = 2014
while ($i < 2021)
#for i in {2014..2020}; do
  if ( -d  /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}a/all ) then
    setenv HYDRA_EB_ALL /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}a/all:${HYDRA_EB_ALL}
  endif
  if ( -d  /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}b/all ) then
    setenv HYDRA_EB_ALL /apps/brussel/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/modules/${i}b/all:${HYDRA_EB_ALL}
  endif
  @ i++
end

setenv MODULEPATH ${HYDRA_EB_ALL}

#Append commercial modules if user belongs to the group
foreach line ( "`cat /etc/commercial_modules`" )
  set gro = `echo $line | awk '{print $1}'`
  set mod = `echo $line | awk '{print $2}'`
  if ( `id |grep -c $gro` == 1 ) then
   setenv MODULEPATH ${MODULEPATH}:${mod}
  endif
end

setenv LMOD_SYSTEM_NAME "${VSC_INSTITUTE_CLUSTER}-${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}"

unset line
unset gro
unset mod
unset HYDRA_EB_ALL
