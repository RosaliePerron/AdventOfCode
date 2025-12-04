file = File.open('input')
banks = file.readlines

banks = banks.map { |batteries| batteries.each_char.map(&:to_i) }
joltage = 0

banks.each do |bank|
  bests = {}

  decimal = 0
  decimal_i = 0
  bank[0..-3].each_with_index do |battery, i|
    if battery > decimal
      decimal = battery 
      decimal_i = i
    end
  end
  
  units = 0
  bank[decimal_i+1..-1].each do |battery|
    if battery > units 
      units = battery 
    end
  end

  puts "#{decimal}#{units}".to_i
  joltage += "#{decimal}#{units}".to_i
end

puts '---', joltage