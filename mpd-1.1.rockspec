package = "mpd"
version = "1.1"
source = {
    url = "https://github.com/kAworu/lua-mpd"
}
description = {
    summary = "Minimalist MPD client library for Lua, using luasocket",
    detailed = [[
        Control an MPD server efficiently without crappy synchronous
        shell mpc bindings
    ]],
    homepage = "https://github.com/kAworu/lua-mpd",
    license = ""
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
