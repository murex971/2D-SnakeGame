class Points
  attr_reader :x, :y

  def initialize(x, y)
    @x = Random.rand(x-1)
    @y = Random.rand(y-1)
  end

  def coordinates
    [x,y]
  end

end
