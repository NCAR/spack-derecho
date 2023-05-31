local i18n = require("i18n")
propT = {
   source = {
      validT = { user = 1 },
      displayT = {
         user = { short = "(U)", full_color = false, color = "blue", doc = "User-generated downstream module", }
      },
   },
   state = {
      validT = { experimental = 1, testing = 1, obsolete = 1 },
      displayT = {
         experimental  = { short = "(E)", full_color = false,  color = "blue",  doc = i18n("ExplM"), },
         testing       = { short = "(T)", full_color = false,  color = "green", doc = i18n("TstM"), },
         obsolete      = { short = "(O)", full_color = false,  color = "red",   doc = i18n("ObsM"), },
      },
   },
   lmod = {
      validT = { sticky = 1 },
      displayT = {
         sticky = { short = "(S)",  color = "red",    doc = i18n("StickyM"), }
      },
   },
   status = {
      validT = { active = 1, },
      displayT = {
         active = { short = "(L)",  color = "yellow", doc = i18n("LoadedM")},
     },
   },
}
