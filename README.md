# MPD.lua

Minimalist MPD client library for Lua, using luasocket.

### Usage

```lua
mpd = require('mpd')
-- default values shown here:
server_settings = {
  hostname = 'localhost',
  port     = 6600,
  desc     = 'localhost',
  password = nil,
  timeout  = 1,
  retry    = 60
}

mpc = mpd.new(server_settings)

-- here are all the functions currently avaiable
mpc:next()
mpc:previous()
mpc:stop()
mpc:volume_up(delta)
mpc:volume_down(delta)
mpc:toggle_random()
mpc:toggle_repeat()
mpc:toggle_play()
mpc:seek(delta)
mpc:protocol_version()

-- But, you can always send any command mpd may accept with mpc:send().
-- Actually, the above methods are just wrappers for mpc:send(),
-- you can view all the available mpd commands here:
--     https://www.musicpd.org/doc/protocol/
-- For example, try:
mpc:send('outputs')
-- It should return a table with all information MPD
-- gives about it's outputs.
```

### Installation

Either put `mpd.lua` in your `package.path` or install it with luarocks:
```sh
luarocks install mpd
```
