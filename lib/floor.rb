class Floor
  attributes :length, :width, :floor

  def initialize(width, length)
    @length = length
    @width = width
    create_floor
  end

  // calculates center points of the board
  def center
    [floor.length/2, floor.first.length/2]
  end

  def print_text(text)
    char_center = text.length/2
    i = 0
    text.chars.each do |char|
      floor[center.first][center.last - char_center + i] = char
      i+=1
    end
  end

  // create the floor and fill it with “.” 
  def create_floor
    @floor = Array.new(length){ Array.new(width, '.') }
  end

end
