---@otaIP 192.168.1.81
--@otaCOM COM4

-- Modules enabled
DISPLAY_PRESENT=false
ENABLE_OTA=false

-- By default always shut down when a remote disconnects.
shutdownOnDisconnect=false


-- Thingspeak channel key for this device.
TS_CHANNEL_KEY="CBSJRYPS1VYOL0G7"


-- These are hardware configuration constants, they really
-- should never need to be changed unless you built a customized
-- version of the board.

SDA_PIN = 7
SCL_PIN = 5
YELLOW_PIN=1
BLUE_PIN=6