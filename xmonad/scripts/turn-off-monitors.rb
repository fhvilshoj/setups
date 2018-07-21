require 'open3'
require 'ostruct'

monitor_query = "xrandr --query | grep -B 1 '.0\\*' | grep -o '^[a-zA-Z0-9]* '"
output = Open3.capture2(monitor_query).first.each_line.to_a.collect(&:strip)
output = output.reject { |c| c.empty? or c == "eDP1" }

command = "xrandr"
for out in output
  command += " --output #{out} --off"
end

`#{command}`
puts command
