if File.exist? "#{dir}/build.gradle"
  if os == :windows
    system("(cd \"#{dir}\" && gradlew idea)")
  else
    system("(cd \"#{dir}\" && ./gradlew idea)")
  end
else
  puts "Not a Java Project!"
end
