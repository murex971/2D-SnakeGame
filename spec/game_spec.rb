require 'spec_helper'
describe Game do
  let(:new_game) {Game.new}

  describe "#new" do
    it "initializes game" do
      expect(new_game.gamefloor).to be_kind_of(Floor)
      expect(new_game.snake).to be_kind_of(Snake)
      expect(new_game.point).to be_kind_of(Point)
    end
  end

  it "#checkSnakePosition checks all checks successfully" do
    expect{new_game.checkSnakePosition}.to_not raise_error(AteItselfError)
    expect{new_game.checkSnakePosition}.to_not change{new_game.snake.body}
  end

  it "#checkIfSnakeAteItself" do
    new_game.snake.parts[0] = new_game.snake.parts.last
    expect{new_game.checkIfSnakeAteItself}.to raise_error(AteItselfError)
    expect{new_game.checkSnakePosition}.to raise_error(AteItselfError)
  end

  it "#checkIfSnakeMetWall" do
    new_game.snake.parts[0][1] = new_game.gamefloor.width
    expect{new_game.checkIfSnakeMetWall}.to change{new_game.snake.parts[0][1]}.from(new_game.gamefloor.width).to(0)
    new_game.snake.parts[0][1] = new_game.gamefloor.width
    expect{new_game.checkSnakePosition}.to change{new_game.snake.parts[0][1]}.from(new_game.gamefloor.width).to(0)
  end

  it "#checkIfSnakeAtePoint" do
    new_game.snake.parts[0] = new_game.point.coordinates
    expect{new_game.checkIfSnakeAtePoint}.to change{new_game.snake.size}.from(4).to(5)
    new_game.snake.parts[0] = new_game.point.coordinates
    expect{new_game.checkSnakePosition}.to change{new_game.snake.size}.from(5).to(6)
  end

  it "#compares pressed key" do
    expect(new_game.compareKey(65, 'a')).to be_truthy
    expect(new_game.compareKey(65, 'A')).to be_truthy
    expect(new_game.compareKey(65, 'Q')).to be_falsey
  end

  it "#executeAction quit on Q" do
    expect(new_game.executeAction('q'.ord)).to eql(false)
  end

  it "#executeAction turn on a" do
    expect{new_game.executeAction('d'.ord)}.to change{new_game.snake.direction}.from(:left).to(:right)
    expect(new_game.executeAction('d'.ord)).not_to be_nil
  end
end
