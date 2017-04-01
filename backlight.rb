#!/usr/bin/env ruby
#
#  backlight.rb
#
#    because xbacklight doesn't work anymore
#

# imports
require 'optparse'

# globals
$VERSION = "0.0.0.1"
$symlinkDir = "/sys/class/backlight/intel_backlight"
$brightnessDir = File.realpath($symlinkDir)

#
# returns an integer of the current brightness level
#
def get_brightness
  if File.directory?($brightnessDir)
    brightnessFile = File.join($brightnessDir, "brightness")
    return File.read(brightnessFile)
  end
end

#
# argument parsing
#
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: backlight.rb [options]"
  opts.version = $VERSION

  opts.on('-i', '--increase [INTEGER]', Integer, "Increase backlight by given integer") do |int| 
    options[:value] = int
  end
  opts.on('-d', '--decrease [INTEGER]', Integer, "Decrease backlight by given integer") do |int|
    options[:value] = int
  end
  opts.on('-g', '--get', "Gets the current setting of your backlight") do
    puts "Current brightness level: #{get_brightness}"
  end
end.parse!

