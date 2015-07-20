if File.exist? "#{dir}/build.gradle"
  puts "Attempting to build Java Project"
  if os == :windows
    system("(cd #{dir} && gradlew build)")
  else
    system("(cd #{dir} && ./gradlew build)")
  end
elsif File.exist? "#{dir}/module.json"
  prebuild = File.absolute_path(File.join(dir, "prebuild.rb"))
  build = File.absolute_path(File.join(dir, "build.rb"))

  require prebuild if File.exist? prebuild

  require 'zip'
  puts "Attempting to build JavaScript project"
  exppath = File.expand_path(".", dir)
  buildfiles = Dir[exppath + "/**/*"]
  exclusions = ["build", "build/*.jsm"]
  exclusions << File.read("#{dir}/exclude.build").split(/\r?\n/) if File.exist? "#{dir}/exclude.build"
  exclusion_list = []
  exclusions = exclusions.flatten
  exclusions.each {|excl| exclusion_list << Dir[exppath + "/" + excl]}
  file_list = buildfiles - exclusion_list.flatten

  moduleconfig = File.read(File.join(dir, "module.json"))
  archive_name = moduleconfig.scan(/"name"\s*:\s*"(.*)"/)[0][0]
  version_match = moduleconfig.scan(/"version"\s*:\s*"(.*)"/)
  archive_name += "_#{version_match[0][0]}" if version_match.length > 0

  archive_name += ".jsm"
  FileUtils.mkdir "#{dir}/build" unless File.exist? "#{dir}/build"
  archive_path = "#{dir}/build/#{archive_name}"

  require build if File.exist? build

  puts "Building Archive: #{archive_name}"
  puts "Including Files: "
  puts file_list.map {|x| "\t#{x.gsub(/\\/, "/").gsub(dir.gsub(/\\/, "/"), "")}\n"}

  FileUtils.rm_rf archive_path if File.exist? archive_path
  Zip::File.open(archive_path, Zip::File::CREATE) do |zipfile|
    file_list.each do |fn|
      relative = fn.gsub(/\\/, "/").gsub(dir.gsub(/\\/, "/"), "")
      zipfile.add(relative[1..relative.length], fn)
    end
  end

  puts "Build Complete"
else
  puts "Can't build: not a valid Toast Project"
end
