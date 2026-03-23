local version = "0.65.0"
local name    = myModuleName()
local base    = pathJoin("/tools", name, "app", version)

prepend_path("PATH", pathJoin(base, "bin"))

help([[
Fish-safe local wrapper for the system Pixi module.

It exposes the Pixi binary without injecting Bash-only completion hooks.

URL: https://pixi.sh
]])
whatis("Name: Pixi")
whatis("Version: " .. version)
whatis("Description: fish-safe wrapper for the system pixi module")
whatis("Keywords: development, python")
whatis("URL: https://pixi.sh")
