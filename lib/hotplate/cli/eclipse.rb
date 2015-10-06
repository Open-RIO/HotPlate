if File.exist? "#{dir}/build.gradle"
  if os == :windows
    system("(cd #{dir} && gradlew eclipse)")
  else
    system("(cd #{dir} && ./gradlew eclipse)")
  end
else
  puts "Not a Java Project!"
end
