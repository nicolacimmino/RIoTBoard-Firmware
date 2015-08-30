--@otaIP 192.168.1.81
---@otaCOM COM4

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

tmr.alarm(0, 1000, 1, function()

	si7021 = require("si7021")
	si7021.init(SDA_PIN, SCL_PIN)
	si7021.read(OSS)
	local humidity = si7021.getHumidity() / 100
	local temperature = si7021.getTemperature() / 100
	si7021 = nil
	package.loaded["si7021"]=nil

  local battery = adc.readvdd33() / 1000
  
  -- Temporary hack for display.
  measuredHumidty = (string.format("Humidity: %3.1f %%",  humidity ))
  measuredTemperature = (string.format("Temperature: %3.1f C",  temperature))
	
  local data = {}
  data[0]=temperature
  data[1]=humidity
  data[2]=battery
  
  riot.sendData(data)
  
end)