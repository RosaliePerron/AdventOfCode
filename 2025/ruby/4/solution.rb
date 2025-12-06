class Warehouse
  attr_accessor :removed

  def initialize
    @valid_rolls = []
    @to_remove = []
    @removed = []
    get_grid
    
    get_rolls
    
    while @to_remove.length > 0
      puts "rolls to remove: #{@to_remove.length}"
      remove_rolls
      get_rolls
    end
  end

  private

  def get_grid
    file = File.open('input')
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
    get_coords_to_check(x, y).each do |coords|
      if @grid[coords[1]][coords[0]] == '@'
        nb_rolls += 1
      end
    end
    
    if nb_rolls < 4
      @to_remove << [x, y]
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

  def remove_rolls
    @to_remove.each do |roll|
      puts "#{roll}"
      @grid[roll[1]][roll[0]] = '.'
      @removed << roll
    end
    @to_remove = []
  end
end 

warehouse = Warehouse.new
puts '---', warehouse.removed.count