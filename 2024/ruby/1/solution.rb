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

total = 0
first.each_with_index do |nb, i|
  total += (nb - second[i]).abs
end

puts total