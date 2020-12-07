$ids = []
File.open("input.txt", "r") do |file|
  file.each_line do |code|
    $ids.append code.gsub(/[BR]/, "1").gsub(/[FL]/, "0").to_i(2)
  end
end

puts $ids.max
