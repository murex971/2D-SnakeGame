require 'spec_helper'
describe Floor do
  describe "#new" do
    it "initializes the floor" do
      expect(Floor.new(40,40).floor).not_to be_nil
    end
  end
  describe "#create_floor" do
    let(:gamefloor){Floor.new(40,40)}
    it "returns an array" do
      expect(gamefloor.floor).to be_instance_of(Array)
    end
    it "returns an array with given size" do
      expect(gamefloor.floor.size).to be_eql(40)
      expect(gamefloor.floor[0].size).to be_eql(40)
    end
    it "returns floor full of . symbols" do
      expect(gamefloor.floor.first.first).to eql('.')
    end
  end
end
