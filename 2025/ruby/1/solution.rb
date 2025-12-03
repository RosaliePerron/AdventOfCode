class Unlock
  attr_accessor :nb_zeros, :nb_dead_zeros

  def initialize
    @position = 50
    @nb_dead_zeros = 0
    @nb_zeros = 0

    process_file
    ingest_sequence
  end

  private

  def process_file 
    file = File.open('input')
    @lines = file.readlines
  end

  def ingest_sequence
    @lines.each do |line|
      direction = line[0]
      movement = line[1..-1].to_i

      move_dial(direction, movement)
    end
  end

  def move_dial(direction, movement)
    1.upto(movement) do |i|
      click(direction)
    end

    if @position == 0
      @nb_dead_zeros += 1
    end
  end

  def click(direction)
    case direction 
    when 'L'
      @position -= 1
    when 'R'
      @position += 1
    end

    if @position == 100
      @position = 0
    elsif @position == -1
      @position = 99
    end

    if @position == 0
      @nb_zeros += 1
    end
  end
end

unlock = Unlock.new
puts unlock.nb_dead_zeros
puts unlock.nb_zeros