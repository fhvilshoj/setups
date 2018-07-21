require 'open3'
require 'optparse'
require 'ostruct'

options = OpenStruct.new
options.action = nil
options.monitor = nil
options.position = "--below"

OptionParser.new do |opts|
  opts.banner = "Usage: monitors.rb [options]"

  opts.on('-a', '--action ACTION', 'Turn monitor on of off.', 'on | off | office | list-all | list (l)' ,'on and off must have monitor specified') { |v| options.action = v }
  opts.on('-m', '--monitor MONITOR_NAME', 'Typically HDMI1 or DP1') { |v| options.monitor = v }
  opts.on('-p', '--position POSITION', 'Position of external monitor') { |v| options.position = "--#{v}" }

end.parse!

command = "xrandr --query | grep '\\bconnected\\b' | grep -o '^\\S*'"
outputs = Open3.capture2(command).first.each_line.to_a.collect(&:strip)
all = Open3.capture2("xrandr --query | grep -o '^\\S*'").first.each_line.to_a.collect(&:strip)

if not options.action
  if outputs.length > 1
    puts "Setting up external monitor #{outputs[1]}"
    `xrandr --output #{outputs[1]} --auto --output #{outputs[0]} --auto #{options.position} #{outputs[1]}`
    `nitrogen --restore`
  end
  if outputs.length == 1
    `xrandr --output #{outputs[0]} --auto`
    `nitrogen --restore`
  end
  exit
end

case options.action
when "office"
  `xrandr --output eDP1 --auto --output HDMI2 --right-of eDP1 --auto --output DP1 --right-of HDMI2 --auto --rotate left`
  `nitrogen --restore`
when "off"
  if options.monitor
    `xrandr --output #{options.monitor} --off`
    `nitrogen --restore`
  else
    puts "Monitor must be specified to turn it off"
    exit
  end
when "on"
  if options.monitor
    `xrandr --output #{options.monitor} --auto --output #{outputs[0]} --auto #{options.position} #{options.monitor}`
    `nitrogen --restore`
  else
    puts "Monitor must be specified to turn it on"
  end
when "list-all"
  puts all
when "list", "l"
  puts outputs
else
  puts "Wrong action use --help for info"
end
