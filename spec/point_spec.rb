require 'spec_helper'
describe Point do
  let(:point){ Point.new(25, 25) }
  describe "#new" do
    it "initializes point with start coords" do
      expect(point).not_to be_nil
      expect(point.x).not_to be_nil
      expect(point.y).not_to be_nil
    end
  end

  it "#coordinates returns array of point's coords" do
    expect(point.coordinates).to eq([point.x, point.y])
  end
end
