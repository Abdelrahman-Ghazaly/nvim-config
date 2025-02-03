return {
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cmd = { "Typr", "TyprStats" },
    config = function()
      local typr = require("typr.state")
      typr.linecount = 5
      typr.random = false
    end,
  },
}
