require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "NCAR and Cray Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules[/%.%d]*/oneapi/2023%.0%.0$'] = 'Compiler-dependent Software - [oneapi/2023.0.0]',
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
