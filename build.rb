puts "Building Windows Installer..."
puts `ruby buildtools/ocra.rb`
puts `gem build hotplate.gemspec`
puts "Build Complete"
