require 'FileUtils'
FileUtils.mkdir "out" unless File.exist? "out"
puts `ocra lib/hotplate/cli/main.rb #{[Dir["lib/hotplate/gems/**/*"], Dir["java/*"], "lib/hotplate/cli/init.rb", "lib/hotplate/cli/build.rb"].flatten.join " "} --no-dep-run --add-all-core --icon buildtools/logo.ico --output out/CLI.exe`
puts `ocra install.rb #{[Dir["lib/hotplate/gems/**/*"], "out/CLI.exe", "toast.bat"].flatten.join " "} --no-dep-run --add-all-core --icon buildtools/logo.ico --output out/ToastInstaller.exe`
