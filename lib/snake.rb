class Snake
  attributes :size, :direction, :position, :parts
  def initialize(x, y)
    @size = 4
    @direction = :left
    @parts = []
    setStartPosition(x, y)
    createSnake
  end

  def createSnake
    size.times do |iteration|
      @parts << [position[0], position[1]+iteration]
    end
  end

  def head
    parts.first
  end

  def body
    parts[1..parts.length-1]
  end

  // randomly set starting position of snake
  def setStartPosition(max_x, max_y)
    @position = [Random.rand(0..max_x-1), Random.rand(0..max_y-1)]
  end

  def increase
    @size += 1
    @parts << parts.last
  end

  def updateHead(idx, value)
    @parts.first[idx] = value
  end

  def turn(key)
    @direction = case key.chr
    when 'w' || 'W'
      :up
    when 's' || 'S'
      :down
    when 'a' || 'A'
      :left
    when 'd' || 'D'
      :right
    else
      direction
    end
  end

  // defines step based on the key
  def step
    newHead = [head.first,head.last]
    case direction
    when :left
      newHead[1] -= 1
    when :right
      newHead[1] += 1
    when :up
      newHead[0] -= 1
    when :down
      newHead[0] += 1
    end
    parts.unshift(newHead)
    parts.pop
  end
end
