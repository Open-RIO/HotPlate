require 'optparse'

trap("INT"){exit}

OptionParser.new do |o|
  o.on("-d DIRECTORY", "--directory", "The directory to start in") {|dir| @dir = dir}
end.parse!

def dir
  @dir ||= "."
  File.absolute_path @dir
end

def os
  if (/Windows/ =~ ENV['OS']) != nil
    return :windows
  elsif (/darwin/ =~ RUBY_PLATFORM) != nil
    return :darwin
  else
    return :linux
  end
end

require 'fileutils'
require "zip"
require "hotplate/version"

puts "HotPlate CLI Version #{HotPlate::VERSION}"
puts
puts "Error: No option selected!" unless ARGV.length > 0
first_arg = ARGV.shift

begin
  (puts "recursion is a bad idea idea idea idea"; exit;) if first_arg == 'main'
  require_relative "#{first_arg}"
rescue LoadError
  puts "Invalid Option: #{first_arg}"
end
