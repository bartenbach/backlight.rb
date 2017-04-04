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
# RETURNS - Current brightness
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
# SETS - New brightness level
#   value - INTEGER - value to modify brightness by
#   increase - BOOLEAN - true to increase, false to decrease
#
def set_brightness(value, increase)
  currentBrightness = get_brightness
  maxBrightness = get_max_brightness
  brightnessFile = File.join($brightnessDir, "brightness")
  if !File.writable?(brightnessFile)
    puts "No write permission to brightness file (are you root?) Aborting"
    abort
  else
    handle = File.open(brightnessFile, 'w')
    if (increase)
      if (currentBrightness == maxBrightness)
        puts "Brightness already at maximum"
        exit
      else
        newLevel = currentBrightness.to_i + value
        if (newLevel >= maxBrightness.to_i)
          handle.puts(maxBrightness)
          puts "Brightness set to maximum level"
        else
          handle.puts(newLevel)
          puts "Brightness increased to #{newLevel}"
        end
      end
    else
      if (currentBrightness == 0) # I assume zero would be the minimum, yeah?
        puts "Brightness already at minimum"
        exit
      else  
        newLevel = currentBrightness.to_i - value
        if (newLevel <= 0)
          handle.puts(0)
          puts "Brightness set to minimum level"
        else
          handle.puts(newLevel)
          puts "Brightness decreased to #{newLevel}"
        end
    end
  end
end

#
# RETURNS - Max brightness
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
    set_brightness(options[:value], true)
  end
  opts.on('-d', '--decrease [INTEGER]', Integer, "Decrease backlight by given integer") do |int|
    options[:value] = int
    set_brightness(options[:value], false)
  end
  opts.on('-g', '--get', "Gets the current setting of your backlight") do
    puts "Current brightness level: #{get_brightness}"
  end
end.parse!
