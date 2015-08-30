# RIoTBoard-Firmware
RIoT implementation for the NodeMCU based RIoT board

GPIO  NodePin Function
16    0       Button Yellow (no interrupt)
14    5       SCL
12    6       Button Blue
13    7       SDA
2     4       LED Red
4     2       LED Green


       PullUp - RST             TXD -
              - ADC             RXD -
            1 - CH_PD        (1)GPIO4 ->YELLOW
          RST<- GPIO16(0)    (2)GPIO5 ->GREEN
          SCL<- GPIO14(5)       GPIO0 - PRG
         BLUE<- GPIO12(6)    (4)GPIO2 - RED
          SDA<- GPIO13         GPIO15 ->GND
              - VCC               GND ->GND
              