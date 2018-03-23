package = "mpd"
version = "1.1.0-1"
source = {
    url = "https://github.com/kAworu/lua-mpd"
}
description = {
    summary = "Minimalist MPD client library for Lua, using luasocket",
    detailed = [[
        Control an MPD (Music Player Daemon) server efficiently with luasocket
        instead of the usual synchronous shell mpc bindings
    ]],
    license = "MIT",
    homepage = "https://github.com/kAworu/lua-mpd",
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
