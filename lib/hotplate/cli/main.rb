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

def gemload name
    libroot = File.expand_path "../../gems", __FILE__
    $:.unshift Dir[libroot + "/#{name}-*/lib"][0]
end

gemload "rubyzip"
require_relative '../version'

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
