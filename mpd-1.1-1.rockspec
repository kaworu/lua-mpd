package = "mpd"
version = "1.1-1"
source = {
    url = "https://github.com/kAworu/lua-mpd"
}
description = {
    summary = "Minimalist MPD client library for Lua, using luasocket",
    detailed = [[
        Control an MPD server efficiently without crappy synchronous
        shell mpc bindings
    ]],
    license = "MIT",
    homepage = "https://github.com/kAworu/lua-mpd",
    issues_url = "https://github.com/kAworu/lua-mpd/issues"
}
dependencies = {
    'luasocket'
}
build = {
    type = 'builtin',
    modules = {
        mpd = 'mpd.lua'
    }
}
