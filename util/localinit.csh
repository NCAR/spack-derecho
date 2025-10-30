# Location variables
setenv INSTALLPATH_ROOT /glade/u/apps/derecho/default/spack/opt/spack
setenv MODULEPATH_ROOT /glade/u/apps/derecho/modules

# Lmod configuration
setenv LMOD_SYSTEM_NAME derecho
setenv LMOD_SYSTEM_DEFAULT_MODULES "ncarenv/25.10:craype/2.7.34:intel/2024.2.1:ncarcompilers/1.1.0:cray-mpich/8.1.32:netcdf/4.9.3"

if ( ! $?MODULEPATH ) then
    setenv MODULEPATH $MODULEPATH_ROOT/environment
else if ( $MODULEPATH !~ *${MODULEPATH_ROOT}* ) then
    setenv MODULEPATH $MODULEPATH_ROOT/environment
endif

# Set defaults for Lmod behavior configuration
setenv LMOD_PACKAGE_PATH /glade/u/apps/derecho/25.10/envs/public/util
setenv LMOD_CONFIG_DIR /glade/u/apps/derecho/25.10/envs/public/util
setenv LMOD_AVAIL_STYLE grouped:system

# Get location of Lmod initialization scripts
setenv LMOD_ROOT /glade/u/apps/derecho/25.10/spack/opt/spack/lmod/8.7.55/gcc/12.5.0/uncg

# Add shell settings so Lmod can be used in bash scripts
setenv PROFILEREAD true
setenv BASH_ENV ${LMOD_ROOT}/lmod/lmod/init/bash 

# Use shell-specific init
set comm = `/bin/ps -p $$ -o cmd= |awk '{print $1}'|sed -e 's/-sh/csh/' -e 's/-csh/tcsh/' -e 's/-//g'`
set shell = `/bin/basename $comm`

source $LMOD_ROOT/lmod/lmod/init/$shell
unset comm shell

# Set system default stuff
setenv NCAR_OS_VERSION `/usr/bin/lsb_release -rs`
setenv NCAR_DEFAULT_PATH /usr/local/bin:/usr/bin:/sbin:/bin
setenv NCAR_DEFAULT_MANPATH /usr/local/share/man:/usr/share/man
setenv NCAR_DEFAULT_INFOPATH /usr/local/share/info:/usr/share/info

setenv PATH ${PATH}:$NCAR_DEFAULT_PATH

if ( ! $?MANPATH ) then
    setenv MANPATH $NCAR_DEFAULT_MANPATH
else
    setenv MANPATH ${MANPATH}:$NCAR_DEFAULT_MANPATH
endif

if ( ! $?INFOPATH ) then
    setenv INFOPATH $NCAR_DEFAULT_INFOPATH
else
    setenv INFOPATH ${INFOPATH}:$NCAR_DEFAULT_INFOPATH
endif

# Set PBS workdir if appropriate
if ( $?PBS_O_WORKDIR  && ! $?NCAR_PBS_JOBINIT ) then
    if ( -d $PBS_O_WORKDIR ) then
        cd $PBS_O_WORKDIR
    endif

    setenv NCAR_PBS_JOBINIT $PBS_JOBID
endif

# Load default modules
if ( ! $?__Init_Default_Modules || ! $?LD_LIBRARY_PATH ) then
  setenv __Init_Default_Modules 1
  module -q restore
endif

# Hide specified modules
setenv LMOD_MODULERCFILE /glade/u/apps/derecho/25.10/envs/public/util/hidden-modules
