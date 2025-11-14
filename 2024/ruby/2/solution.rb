file = File.open('input.example')
lines = file.readlines

def part_one(lines)
  min = 1
  max = 3

  total = 0
  lines.each do |line|
    data = line.split(' ')

    # a positive direction would mean increasing, negative would mean decreasing
    direction = nil
    data.each_with_index do |point, i|
      current_direction = nil
      point = point.to_i

      if i == data.length - 1
        total += 1
        break
      end

      current_direction = direction.positive? unless i == 0
      direction = point - data[i + 1].to_i

      if (
        direction.abs > max || 
        direction.abs < min || 
        (!current_direction.nil? && direction.positive? != current_direction)
      )
        break
      end
    end
  end

  total
end

puts part_one(lines)