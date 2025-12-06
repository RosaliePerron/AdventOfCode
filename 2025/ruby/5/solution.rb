class Database
  attr_accessor :nb_fresh

  def initialize
    init_db
    
    @nb_fresh = 0
    compute_fresh_ingredients
  end

  private

  def init_db
    file = File.open('input')
    @db = file.readlines.map{ |line| line.strip }
    
    seperator_index = 0
    @db.each_with_index do |line, i|
      if line == ''
        seperator_index = i
        break
      end
    end
    
    @ids = []
    @db[seperator_index+1..-1].each do |id|
      @ids << id.to_i
    end
  
    @fresh_ranges = []
    @db[0..seperator_index-1].each do |range|
      @fresh_ranges << range.split('-').map{ |limit| limit.to_i }
    end
  end

  def compute_fresh_ingredients
    @ids.each do |id|
      @fresh_ranges.each do |low, high|
        if low <= id && high >= id 
          @nb_fresh += 1
          puts "#{id} -> fresh!"
          break
        end
      end
      puts "#{id} -> spoiled..."
    end
  end
end 

db = Database.new
puts '---', db.nb_fresh