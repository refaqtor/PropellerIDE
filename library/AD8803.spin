{{
*****************************************
* AD8803 Octal 8-Bit Trim DAC Demo v1.0 *
* Author: Beau Schwabe                  *
* Copyright (c) 2007 Parallax           *
* See end of file for terms of use.     *
*****************************************
}}
PUB Set(CS,SDI,CLK,DACaddress,DACvalue)
    dira[CS]  := 1                                      'Make  CS  pin an output
    dira[SDI] := 1                                      'Make  SDI pin an output
    dira[CLK] := 1                                      'Make  CLK pin an output

    CS         := 0 #> CS         <# 31                 'Limit CS's         range from 0-31
    SDI        := 0 #> SDI        <# 31                 'Limit SDI's        range from 0-31
    CLK        := 0 #> CLK        <# 31                 'Limit CLK's        range from 0-31
    DACaddress := 0 #> DACaddress <# 7                  'Limit DACaddress's range from 0- 7
    
    outa[CLK] := 0                                      'Bring CLK low ; load AD8803 data
    outa[CS]  := 0                                      'Bring CS low
    
    SendData(SDI,CLK,3,DACaddress)                      'Select Address
    SendData(SDI,CLK,8,DACvalue)                        'Select Value
    
    outa[CS] := 1                                       'Bring CS high ; latch AD8803 data

PRI SendData(SDI,CLK,Bits,Data)|temp                    'Send DATA MSB first
    temp := 1 << ( Bits - 1 )
    repeat Bits
      outa[SDI] := (Data & temp)/temp                   'Set bit value
      outa[CLK] := 1                                    'Clock bit
      outa[CLK] := 0                                    'Clock bit
      temp := temp / 2
DAT
{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}      