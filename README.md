# MPD.lua

Minimalist MPD client library for Lua, using luasocket.

### Usage

```lua
mpd = require('mpd')
-- default values shown here:
server_settings = {
  hostname = 'localhost',
  port = 6600,
  desc = localhost,
  password = nil,
  timeout = 1
  retry = 60
}
mpc = mpd.new(server_settings)
-- here are all the functions currently avaiable
mpc:next()
mpc:previous()
mpc:protocol_version()
mpc:seek()
mpc:stop()
mpc:toggle_play()
mpc:toggle_random()
mpc:toggle_repeat()
mpc:volume_down()
mpc:volume_up = <function 12>
-- But, you can always send any command may mpd accept with:
mpc:send()
-- You can 
-- The above methods are just wrappers for mpc:send()
-- You can view all the available wrappers here:
-- https://www.musicpd.org/doc/protocol/
-- For example, try:
mpc:send('outputs')
-- It should return a table with all information MPD
-- gives on it's outputs
```

### Installation

Either put `mpd.lua` in your `package.path` or install it with:
```sh
luarocks install mpd
```
