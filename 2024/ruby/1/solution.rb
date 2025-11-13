file = File.open("input")
lines = file.readlines

first = []
second = []

lines.each do |line|
  a, b = line.split(" ").map(&:to_i)
  first << a
  second << b
end

first = first.sort 
second = second.sort

def part_one(first, second)
  total = 0
  first.each_with_index do |nb, i|
    total += (nb - second[i]).abs
  end

  total
end

def part_two(first, second)
  total = 0
  first.each do |nb|
    total += nb * second.select { |n| n == nb }.length
  end

  total
end

def part_two_alt(first, second)
  map = {}
  second.each do |nb|
    map[nb] = (map[nb] || 0) + 1
  end

  total = 0
  first.each do |nb|
    total += nb * (map[nb] || 0)
  end
  
  total
end

puts part_two_alt(first, second)