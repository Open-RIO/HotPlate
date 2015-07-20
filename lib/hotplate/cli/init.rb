require 'FileUtils'

def java
  puts "What is your Team Number? (0000)"
  team = gets.chop!.to_i.to_s     # Ensures it's a proper number :)
  clazz = "#{@path}/src/main/java/frc/team#{team}/#{@name}/RobotModule.java"
  jin = File.expand_path "../../java", __FILE__
  FileUtils.cp_r "#{jin}/.", @path

  build = File.read File.join(@path, "build.gradle")
  build = build.gsub "%%TEAM", team
  build = build.gsub "%%NAME", @name
  File.write File.join(@path, "build.gradle"), build

  templ = File.join(@path, "template.java")
  template = File.read templ
  template = template.gsub "%%TEAM", team
  template = template.gsub "%%NAMED", @name.downcase
  template = template.gsub "%%NAME", @name
  FileUtils.mkdir_p File.expand_path("..", clazz)
  File.write clazz, template
  File.delete templ

  begin
    FileUtils.chmod 0777, %w(build.gradle, gradlew)
  rescue; end
end

def javascript
  puts "What is your main script class name? [main.js]"
  name = gets.chop!
  name = "main.js" if name == ""
  name += ".js" unless name =~ /^(.*)\.js$/
  File.write("#{@path}/module.json", "{\n\t\"name\": \"#{@name}\",\n\t\"script\": \"#{name}\"\n}")
  File.write("#{@path}/#{name}", "console.log('Hello Toast!');")
end

puts "Creating a new Toast Module."

puts "What is the name of your Module?"
@name = gets.chop!
@path = File.join dir, @name
if File.exist? @path
  puts "Module already exists? Want to override? (THIS CANNOT BE UNDONE) [y/n]"
  inp = gets.chop!
  if inp =~ /(y(es)?)|1|(t(rue)?)/i
    puts "Overriding..."
    FileUtils.rm_rf @path
  else
    puts "Aborting..."
    exit
  end
end
FileUtils.mkdir @path

puts "What kind of Toast Module would you like to create? [java/javascript] (java)"
option = gets.chop!
if option =~ /javas(cript)?/i
  javascript
else
  java
end

puts "Toast Module Created! #{@name}"
