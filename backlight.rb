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

# argument parsing
options = {}
OptionParser.new do |opt|
  opt.on('-i', '-increase VALUE') { |o| options[:value] = o }
  opt.on('-d', '-decrease VALUE') { |o| options[:value] = o }
end.parse!

puts options
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
