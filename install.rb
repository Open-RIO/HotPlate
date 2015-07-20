require 'FileUtils'

def path
  "C:/Program Files/OpenRIO"
end

install_location = "#{path}/hotplate"
FileUtils.mkdir_p "#{install_location}/bin"

puts "Installing HotPlate to #{install_location}..."

FileUtils.cp File.expand_path("../CLI.exe", __FILE__), install_location
FileUtils.cp File.expand_path("../toast.bat", __FILE__), "#{install_location}/bin"

puts "Adding CLI shortcut..."
begin
    path = ENV['Path']
    bindir = "#{install_location}\\bin"
    File.write "#{install_location}/path.backup", path

    require 'win32/registry'
    require 'Win32API'

    unless path.include? bindir
      Win32::Registry::HKEY_LOCAL_MACHINE.open("SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment", Win32::Registry::KEY_WRITE) do |reg|
        reg.write('Path', Win32::Registry::REG_SZ, path + ";#{bindir}")
      end

      SendMessageTimeout = Win32API.new('user32', 'SendMessageTimeout', 'LLLPLLP', 'L')
      HWND_BROADCAST = 0xffff
      WM_SETTINGCHANGE = 0x001A
      SMTO_ABORTIFHUNG = 2
      result = 0
      SendMessageTimeout.call(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 'Environment', SMTO_ABORTIFHUNG, 5000, result)
    end
rescue => e
  p $!, *$@
end

puts "Install Complete. Hit enter to exit"
gets
