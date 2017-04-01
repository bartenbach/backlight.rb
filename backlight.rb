#!/usr/bin/env ruby
#
#  backlight.rb
#
#    because xbacklight doesn't work anymore
#
$VERSION = "0.0.0.1"
$symlinkDir = "/sys/class/backlight/intel_backlight"
$brightnessDir = File.realpath($symlinkDir)

USAGE = <<ENDUSAGE
Usage:
   backlight [-inc] [-dec] value
ENDUSAGE

HELP = <<ENDHELP
   -h, --help         Show this help.
   -inc               Increase brightness by [value]
   -dec               Decrease brightness by [value]
ENDHELP
  
ARGV.each do |arg|
  case arg
    when '-h', '--help'      then ARGS[:help]     = true
    when '-v','--version'    then ARGS[:version]  = true
    when '-inc'              then next_arg = :value
    when '-dec'              then next_arg = :value
  end
end

puts "backlight.rb v#{VERSION}" if ARGS[:version]
#
# returns an integer of the current brightness level
#
def get_brightness
  if File.directory?($brightnessDir)
    brightnessFile = File.join($brightnessDir, "brightness")
    return File.read(brightnessFile)
  end
end

puts get_brightness
