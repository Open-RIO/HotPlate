require 'FileUtils'
FileUtils.mkdir "out" unless File.exist? "out"
puts `ocra lib/hotplate/cli/main.rb #{[Dir["lib/hotplate/gems/**/*"], Dir["lib/hotplate/java/*"], Dir["lib/hotplate/cli/*"], "lib/hotplate/version.rb"].flatten.join " "} --no-dep-run --add-all-core --icon buildtools/logo.ico --output out/CLI.exe`
puts `ocra install.rb #{[Dir["lib/hotplate/gems/**/*"], "out/CLI.exe", "toast.bat"].flatten.join " "} --no-dep-run --add-all-core --icon buildtools/logo.ico --output out/ToastInstaller.exe`
