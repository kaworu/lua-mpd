-- Small interface to MusicPD
-- use luasocket, with a persistant connection to the MPD server.
--
-- Author: Alexandre "kAworu" Perrin <kaworu at kaworu dot ch>
--
-- based on a netcat version from Steve Jothen <sjothen at gmail dot com>
-- (see http://github.com/otkrove/ion3-config/tree/master/mpd.lua)
require("socket")

-- Grab env
local socket = socket
local string = string
local tonumber = tonumber
local setmetatable = setmetatable
local os = os

-- Music Player Daemon Lua library.
module("mpd")

MPD = {
} MPD_mt = { __index = MPD }

-- create and return a new mpd client.
-- the settings argument is a table with theses keys:
--      hostname: the MPD's host (default localhost)
--      port:     MPD's port to connect to (default 6600)
--      desc:     server's description (default hostname)
--      password: the server's password (default nil, no password)
--      timeout:  time in sec to wait for connect() and receive() (default 1)
--      retry:    time in sec to wait before reconnect if error (default 60)
function new(settings)
  local client = {}
  if settings == nil then settings = {} end

  client.hostname = settings.hostname or "localhost"
  client.port     = settings.port or 6600
  client.desc     = settings.desc or client.hostname
  client.password = settings.password
  client.timeout  = settings.timeout or 1
  client.retry    = settings.retry or 60

  setmetatable(client, MPD_mt)

  return client
end


-- calls the action and returns the server's response.
--      Example: if the server's response to "status" action is:
--              volume: 20
--              repeat: 0
--              random: 0
--              playlist: 599
--              ...
--      then the returned table is:
--      { volume = 20, repeat = 0, random = 0, playlist = 599, ... }
function MPD:send(action)
  local command = string.format("%s\n", action)
  local values = {}

  -- connect to MPD server if not already done.
  if not self.connected then
    if not self.last_try or (os.time() - self.last_try) > self.retry then
      self.socket = socket.tcp()
      self.socket:settimeout(self.timeout, 't')
      self.last_try = os.time()
      self.connected = self.socket:connect(self.hostname, self.port)
      if self.connected and self.password then
        self:send(string.format("password %s", self.password))
      end
    end
  end

  if not self.connected then
    return {}
  end

  self.socket:send(command)

  local line = ""
  while not line:match("^OK$") do
    line = self.socket:receive("*l")
    if not line then -- closed,timeout (mpd killed?)
      self.connected = false
      return self:send(action)
    end

    if line:match(string.format("^ACK", action)) then
      return { errormsg = line }
    end

    local _, _, key, value = string.find(line, "([^:]+):%s(.+)")
    if key then
      values[string.lower(key)] = value
    end
  end

  return values
end

function MPD:next()
  self:send("next")
end

function MPD:previous()
  self:send("previous")
end

function MPD:stop()
  self:send("stop")
end

-- no need to check the new value, mpd will set the volume in [0,100]
function MPD:volume_up(delta)
  local stats = self:send("status")
  local new_volume = tonumber(stats.volume) + delta
  self:send(string.format("setvol %d", new_volume))
end

function MPD:volume_down(delta)
  self:volume_up(-delta)
end

function MPD:toggle_random()
  local stats = self:send("status")
  if tonumber(stats.random) == 0 then
    self:send("random 1")
  else
    self:send("random 0")
  end
end

function MPD:toggle_repeat()
  local stats = self:send("status")
  if tonumber(stats["repeat"]) == 0 then
    self:send("repeat 1")
  else
    self:send("repeat 0")
  end
end

function MPD:toggle_play()
  if self:send("status").state == "stop" then
    self:send("play")
  else
    self:send("pause")
  end
end

-- vim:filetype=lua:tabstop=8:shiftwidth=2:fdm=marker:
