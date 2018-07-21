-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config
-- font = "xft:Fixed-"8,
-- This is setup for dual 1920x1080 monitors, with the right monitor as primary
Config {
    font = "xft:SFNS Display:size=10,FontAwesome:size=10"
    bgColor = "#050505",
    fgColor = "#ffffff",
    position = TopW L 95,
    lowerOnStart = True,
    commands = [
        Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
	Run Date "%a %b %_d %l:%M" "date" 100,
	Run Com "bash" ["/home/fhv/.xmonad/bin/scripts/wifi.sh"] "wifi" 30,
	Run Com "python" ["/home/fhv/.xmonad/bin/scripts/brightness-level.py"] "bright" 6,
	Run Battery [ "--template" , "Batt: <acstatus>"
                    , "--Low"      , "10"        -- units: %
                    , "--High"     , "80"        -- units: %
                    , "--low"      , "darkred"
                    , "--normal"   , "darkorange"
                    , "--high"     , "darkgreen"

                    , "--" -- battery specific options
                              -- discharging status
                              , "-o"	      , "<left>% (<timeleft>)"
                              -- AC "on" status
                              , "-O"	  , "<fc=#dAA520>Ch(<left>%)</fc>"
                              -- charged status
                              , "-i"	  , "<fc=#006000>Charged</fc>"
                             ] 50,
	Run Com "bash" ["/home/fhv/.xmonad/bin/scripts/keyboard_layout.sh"] "keys" 2,
	Run Com "bash" ["/home/fhv/.xmonad/bin/scripts/volume.sh"] "vol" 2,
	Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{<fc=#ab9638>|</fc>  %multicpu%  <fc=#ab9638>|</fc>  %memory%  <fc=#ab9638>|</fc>  %swap%  <fc=#ab9638>|</fc>  %wifi%  <fc=#ab9638>|</fc>  <fc=#FFFFCC>%date%</fc>  <fc=#ab9638>|</fc>  <fc=#af5b65>%bright%</fc>  <fc=#ab9638>|</fc>  <fc=#af5b65>%vol%</fc>  <fc=#ab9638>|</fc>  %battery%  <fc=#ab9638>|</fc>  %keys%"
}
-- Run Wireless "wlan0" ["-t", "WiFi: <essid>, <qualityvbar>", "-n", "#FFFFCC"] 10
-- %wlan0% 
--         Run Weather "EKAH" ["-t","<tempC>C <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
	