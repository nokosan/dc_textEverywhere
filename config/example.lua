Config.Lists["example"] = {
  uid = "example", -- unique id
  authorizedJobs = {
    police = { 0, 1, 2, 3, 4 },
    -- jobname = {job gardes} # not job label name
    -- example = {} # any grades example job
  },
  -- authorizedJobs = {} # means any job / anyone can use
  polyZone = {
    data = {
      vector3(-565.92, -1073.5, 21.33),
      vector3(-592.12, -1073.5, 21.33),
      vector3(-592.12, -1051.75, 21.33),
      vector3(-565.92, -1051.75, 21.33),
    },
    minZ = 21,
    maxZ = 26,
  },
  debug = true,
}
