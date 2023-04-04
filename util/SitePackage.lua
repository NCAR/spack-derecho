require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "NCAR and Cray Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules[/%.%d]*/nvhpc/23%.1$'] = 'Compiler-dependent Software - [nvhpc/23.1]',
      ['modules[/%.%d]*/oneapi/2023%.0%.0$'] = 'Compiler-dependent Software - [oneapi/2023.0.0]',
      ['modules[/%.%d]*/cce/15%.0%.1$'] = 'Compiler-dependent Software - [cce/15.0.1]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.25/nvhpc/23%.1$'] = 'MPI-dependent Software - [nvhpc/23.1 + cray-mpich/8.1.25]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.25/oneapi/2023%.0%.0$'] = 'MPI-dependent Software - [oneapi/2023.0.0 + cray-mpich/8.1.25]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.25/cce/15%.0%.1$'] = 'MPI-dependent Software - [cce/15.0.1 + cray-mpich/8.1.25]',
      ['modules[/%.%d]*/cray%-mpich/8%.1%.25/gcc/12%.2%.0$'] = 'MPI-dependent Software - [gcc/12.2.0 + cray-mpich/8.1.25]',
      ['modules[/%.%d]*/gcc/12%.2%.0$'] = 'Compiler-dependent Software - [gcc/12.2.0]',
      ['perftools/22%.12%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/22.12.0]',
      ['modulefiles/perftools/22%.12%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/22.12.0]',
      ['perftools/23%.02%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/23.02.0]',
      ['modulefiles/perftools/23%.02%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/23.02.0]',
      ['perftools/23%.03%.0/modulefiles$'] = 'Cray Performance Analysis Tools - [perftools-base/23.03.0]',
      ['modulefiles/perftools/23%.03%.0$'] = 'Cray Performance Analysis Tools - [perftools-base/23.03.0]',
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
