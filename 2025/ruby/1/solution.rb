class Unlock
  attr_accessor :nb_zeros

  def initialize
    @position = 50
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
    case direction 
    when 'L'
      @position -= movement
    when 'R'
      @position += movement
    end

    calculate_overflow

    if @position === 0
      @nb_zeros += 1
    end
  end

  def calculate_overflow
    while @position < 0 || @position > 99
      if @position < 0
        @position = 99 + @position + 1
      elsif @position > 99
        @position = 0 + (@position - 99) - 1
      end
    end
  end
end

unlock = Unlock.new
puts unlock.nb_zeros