class Warehouse
  attr_accessor :rolls, :valid_rolls

  def initialize
    @valid_rolls = []
    get_grid
    get_rolls
  end

  private

  def get_grid
    file = File.open('input.example')
    @grid = file.readlines.map{ |line| line.chars }
  end

  def get_rolls
    @rolls = []
    @grid.each_with_index do |row, y|
      row.each_with_index do |pos, x|
        roll = [x, y]
        if pos == '@'
          @rolls << roll
          check_if_valid(x, y)
        end
      end
    end
  end

  def check_if_valid(x, y)
    nb_rolls = 0
    puts "coords: #{x}, #{y}"
    puts "to check: #{get_coords_to_check(x, y)}"
    get_coords_to_check(x, y).each do |coords|
      x = coords[0]
      y = coords[1]
      if @grid[y][x] == '@'
        puts "neighbour: #{x}, #{y}"
        nb_rolls += 1
      end
    end
    
    if nb_rolls < 4
      @valid_rolls << [x, y]
    end
  end

  def get_coords_to_check(x, y)
    coords = []
    1.upto(3) do |row| 
      next_y = y + get_mod(row)
      next if next_y < 0 || next_y > @grid.length - 1

      1.upto(3) do |col|
        next_x = x + get_mod(col)
        next if next_x < 0 || next_x > @grid[0].length - 2
        
        coord = [next_x, next_y]
        coords << coord if [x, y] != coord
      end
    end
    
    coords
  end

  def get_mod(curr)
    return -1 if curr == 1
    return 0 if curr == 2
    return 1 if curr == 3
  end
end 

warehouse = Warehouse.new
puts '---', warehouse.valid_rolls.count