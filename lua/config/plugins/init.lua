return {
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cmd = { "Typr", "TyprStats" },
    config = function()
      local typr = require("typr.state")
      typr.linecount = 3
      typr.random = false
    end,
  },
}
