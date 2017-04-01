#!/usr/bin/env ruby
#
#  backlight.rb
#
#    because xbacklight doesn't work anymore
#

#
# imports
#
require 'optparse'

#
# globals
#   if you want to use this, you'll likely have to change the symlinkDir
#
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
  else
    puts "Invalid directory.  Please change the symlinkDir.  Aborting"
    abort
  end
end

#
# increases brightness by passed value
#
def increase_brightness(value)
  currentBrightness = get_brightness
  maxBrightness = get_max_brightness
  if (currentBrightness == maxBrightness)
    puts "Brightness already at maximum"
    exit
  else
    brightnessFile = File.join($brightnessDir, "brightness")
    if !File.writable?(brightnessFile)
      puts "No write permission to brightness file (are you root?) Aborting"
      abort
    else
      newLevel = value + currentBrightness
    end
  end
end

#
# gets max brightness from file and handles errors
#
def get_max_brightness
  maxBrightnessFile = File.join($brightnessDir, "max_brightness")
  if File.exist?(maxBrightnessFile)
    return File.read(maxBrightnessFile)
  else
    puts "Unable to read max brightness file!  Aborting"
    abort
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
    increase_brightness(options[:value])
  end
  opts.on('-d', '--decrease [INTEGER]', Integer, "Decrease backlight by given integer") do |int|
    options[:value] = int
  end
  opts.on('-g', '--get', "Gets the current setting of your backlight") do
    puts "Current brightness level: #{get_brightness}"
  end
end.parse!

