require 'io/console'
class Game
  attr_reader :gamefloor, :snake, :points
  def initialize(x=11, y=11)
    @gameboard = Floor.new(x, y)
    @snake = Snake.new(gamefloor.width, gamefloor.length)
    @food = Points.new(gamefloor.width, gamefloor.length)
  end

  def print_floor
    system('clear')
    puts "Your size is: #{snake.size} |  [Q]uit"
    puts "---------------------------"
    gamefloor.floor.each do
      |line| puts line.each{|item| item}.join(" ")
    end
  end

  def show
    gamefloor.createFloor
    @gameboard.board[food.x][food.y] = 'o'
    snake.parts.each do |part|
      @gameboard.board[part.first][part.last] = 'x'
    end
    print_board
  end

def show_message(text)
    gamefloor.createFloor
    gameboard.print_text(text)
    print_board
  end

  def showStartScreen
    start = false
    while start == false
      system('clear')
      puts "\n
        .........................................................................................................
        ................................................Press [S]tart............................................
        .........................................................................................................
      "
      key = GetKey.getkey
      sleep(0.5)
      if key && compareKey(key, 's')
        start = true
      end
    end
  end

  def checkSnakePosition
    checkIfSnakeMetWall
    checkIfSnakeAteFood
    checkIfSnakeAteItself
  end

def checkIfSnakeAteItself
    if snake.body.include? snake.head
      raise AteItselfError
    end
  end

  def checkIfSnakeMetWall
    snake.updateHead(1,0) if snake.head[1] > gamefloor.width-1
    snake.updateHead(1, gamefloor.width-1) if snake.head[1] < 0
    snake.updateHead(0, 0) if snake.head[0]  > gamefloor.length-1
    snake.updateHead(0, gamefloor.length-1) if snake.head[0] < 0
  end

  def checkIfSnakeAteFood
    if snake.head[0] == food.x && snake.head[1] == food.y
      snake.increase
      @food = Food.new(gameboard.width, gameboard.length)
    end
  end

  def start
    showStartScreen
    begin
      tick
    rescue AteItselfError
      show_message("Game over")
    end
  end

  def tick
    in_game = true
    while in_game
      show
      sleep(0.1)
      if key = GetKey.getkey
        in_game = executeAction(key)
      end
      snake.step
      checkSnakePosition
    end
    show_message("Game quit")
  end

  def executeAction key
    return false if compareKey(key, 'q')
    snake.turn(key)
  end

  def compareKey(key, char)
    key.chr == char.downcase || key.chr == char.upcase
  end
end
