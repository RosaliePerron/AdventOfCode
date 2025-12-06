def get_banks
  file = File.open('input.example')
  banks = file.readlines
  banks.map { |batteries| batteries.each_char.map(&:to_i) }
end

def part_one
  joltage = 0
  banks = get_banks

  banks.each do |bank|
    number = []
    number_i = []

    0.upto(1) do |n_i|
      bank.each_with_index do |battery, i|
        if number.length == n_i
          number << battery 
          number_i << i
          next
        end

        if number[n_i] < battery 
          number[n_i] = battery
          number_i[n_i] = i
        end
      end

      bank.delete(number_i[n_i])
    end

    puts number
  end

  joltage
end

def part_two
  joltage = 0
  banks = get_banks
end

puts '---', part_one