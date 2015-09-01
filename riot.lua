---@otaIP 192.168.1.81
--@otaCOM COM4
--@compile

-- RIoT module is part of Framework for RIoTBoard.
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

responseCallbackFunction = nil

function M.sendData(data, onResponseCallback)
  sendData(data[0] or "", data[1] or "", data[2] or "")
  M.responseCallbackFunction = onResponseCallback
end

-- We use thingspeak as backend for now, this will wrap RIoT calls
--  when RIoT backend ready.
function sendData(f1, f2, f3)      
  local conn=net.createConnection(net.TCP, 0)
  conn:on("receive", function(conn, payload) responseReceived(payload) end )
  conn:connect(80,"184.106.153.149")
  conn:send("GET /update?key=" .. TS_CHANNEL_KEY .. "&field1=" .. f1 
      .. "&field2=" .. f2
      .. "&field3=" .. f3
      .. " HTTP/1.1\r\nHost: api.thingspeak.com\r\n"
      .."Connection: close\r\nAccept: */*\r\n\r\n")
  --conn:close()
end

function responseReceived(payload)
  M.responseCallbackFunction()
end

return M
