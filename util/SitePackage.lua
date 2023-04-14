require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "Module Stack Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules/[^/]+/cray%-mpich/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/aocc/[^/]*$'] = 'MPI-dependent Software - [aocc + openmpi]',
      ['modules/[^/]+/aocc/[^/]*$'] = 'Compiler-dependent Software - [aocc]',
      ['modules/[^/]+/cray%-mpich/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/arm/[^/]*$'] = 'MPI-dependent Software - [arm + openmpi]',
      ['modules/[^/]+/arm/[^/]*$'] = 'Compiler-dependent Software - [arm]',
      ['modules/[^/]+/cray%-mpich/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/cce/[^/]*$'] = 'MPI-dependent Software - [cce + openmpi]',
      ['modules/[^/]+/cce/[^/]*$'] = 'Compiler-dependent Software - [cce]',
      ['modules/[^/]+/cray%-mpich/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/clang/[^/]*$'] = 'MPI-dependent Software - [clang + openmpi]',
      ['modules/[^/]+/clang/[^/]*$'] = 'Compiler-dependent Software - [clang]',
      ['modules/[^/]+/cray%-mpich/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/gcc/[^/]*$'] = 'MPI-dependent Software - [gcc + openmpi]',
      ['modules/[^/]+/gcc/[^/]*$'] = 'Compiler-dependent Software - [gcc]',
      ['modules/[^/]+/cray%-mpich/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/intel/[^/]*$'] = 'MPI-dependent Software - [intel + openmpi]',
      ['modules/[^/]+/intel/[^/]*$'] = 'Compiler-dependent Software - [intel]',
      ['modules/[^/]+/cray%-mpich/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/nag/[^/]*$'] = 'MPI-dependent Software - [nag + openmpi]',
      ['modules/[^/]+/nag/[^/]*$'] = 'Compiler-dependent Software - [nag]',
      ['modules/[^/]+/cray%-mpich/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/oneapi/[^/]*$'] = 'MPI-dependent Software - [oneapi + openmpi]',
      ['modules/[^/]+/oneapi/[^/]*$'] = 'Compiler-dependent Software - [oneapi]',
      ['modules/[^/]+/cray%-mpich/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + cray-mpich]',
      ['modules/[^/]+/hpcx%-mpi/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + hpcx-mpi]',
      ['modules/[^/]+/intel%-mpi/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + intel-mpi]',
      ['modules/[^/]+/intel%-oneapi%-mpi/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + intel-oneapi-mpi]',
      ['modules/[^/]+/mpi%-serial/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + mpi-serial]',
      ['modules/[^/]+/mpich/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + mpich]',
      ['modules/[^/]+/mvapich2/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + mvapich2]',
      ['modules/[^/]+/mvapich2%-gdr/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + mvapich2-gdr]',
      ['modules/[^/]+/openmpi/[^/]+/pgi/[^/]*$'] = 'MPI-dependent Software - [pgi + openmpi]',
      ['modules/[^/]+/pgi/[^/]*$'] = 'Compiler-dependent Software - [pgi]',
      ['perftools/[^/]+/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base]',
      ['modulefiles/perftools/[^/]*$'] = 'Cray Performance Analysis Tools - [perftools-base]',
   },
}

function avail_hook(t)
   local availStyle = masterTbl().availStyle
   local styleT     = mapT[availStyle]
   if (not availStyle or availStyle == "system" or styleT == nil) then
      return
   end

   for k,v in pairs(t) do
      for pat,label in pairs(styleT) do
         if (k:find(pat)) then
            t[k] = label
            break
         end
      end
   end
end

hook.register("avail",avail_hook)
