---@otaIP 192.168.1.81
--@otaCOM COM4

-- Application module is part of Framework for RIoTBoard.
-- This is where user application code goes. This is just an example, your code
-- goes here.

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

board.greenOn()

si7021 = require("si7021")
si7021.init(SDA_PIN, SCL_PIN)
si7021.read(OSS)
local humidity = si7021.getHumidity() / 100
local temperature = si7021.getTemperature() / 100
si7021 = nil
package.loaded["si7021"]=nil

local battery = adc.readvdd33() / 1000

-- Temporary hack for display.
--measuredHumidty = (string.format("Humidity: %3.1f %%",  humidity ))
--measuredTemperature = (string.format("Temperature: %3.1f C",  temperature))

data = {}
data[0]=temperature
data[1]=humidity
data[2]=battery

local networkAttempts = 0

function checkNetwork()
  
  -- Avoid draining battery in case WiFi is not
  -- available.
  networkAttempts = networkAttempts + 1
  if networkAttempts > 10 then
    terminate()
  end
  
  if wifi.sta.getip() ~= nil then
  
    -- Send the data but shutdown if we don't get
    -- a reply witinh 5 seconds.
    tmr.stop(1)
    tmr.alarm(1,5000,0, function() terminate() end)
    riot.sendData(data, terminate)
  end
end

function terminate()
  node.dsleep(60000000, 2)
end

-- Check we got network every 2 seconds.
tmr.alarm(1,2000,1, function() checkNetwork() end)
