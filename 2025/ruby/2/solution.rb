file = File.open('input')
ids = file.readlines[0].split(',')

ids = ids.map { |range| range.split('-').map{ |id| id.to_i } }
invalid_ids = []
invalid_long_ids = []

ids.each do |start, finish|
  start.upto(finish) do |id|
    id = id.to_s
    if (
      id == (id[0] * 2) || 
      id == id[0] * id.length
    ) && id != id[0]
      puts "#{id[0]} from #{id} (#{start}-#{finish})"
      invalid_long_ids << id.to_i 
      next
    end

    1.upto(id.length) do |chunk|
      to_break = false
      pattern = id[0..chunk]
      next if id == pattern

      if id == pattern * 2
        invalid_ids << id.to_i 
      end
      
      if id == (pattern * (id.length / pattern.length))
        puts "#{pattern} from #{id} (#{start}-#{finish})"
        invalid_long_ids << id.to_i
        to_break = true
      end

      break if to_break
    end
  end
end

puts '---', invalid_long_ids.sum