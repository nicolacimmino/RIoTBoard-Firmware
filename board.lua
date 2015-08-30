--@otaIP 192.168.1.81
---@otaCOM COM4

-- Board module is part of Framework for RIoTBoard.
-- Provides control over the board I/O functionality.

--  Copyright (C) 2015 Nicola Cimmino

--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.

--   This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.

--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see http://www.gnu.org/licenses/.

local moduleName = ...
local M = {}
_G[moduleName] = M

function M.greenOn()
  gpio.write(2, gpio.HIGH)
end

function M.greenOff()
  gpio.write(2, gpio.LOW)
end

function M.redOn()
  gpio.write(4, gpio.HIGH)
end

function M.redOff()
  gpio.write(4, gpio.LOW)
end

function M.bindYellow(bindTo)
  bind(1, bindTo)
end

function M.bindBlue(bindTo)
  bind(6, bindTo)
end

function bind(pin, bindTo)
  gpio.mode(pin, gpio.INT)
  gpio.trig(pin, "up", bindTo)
end

gpio.mode(2, gpio.OUTPUT)
gpio.mode(4, gpio.OUTPUT)

M.greenOff()
M.redOff()

return M
