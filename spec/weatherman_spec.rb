require './lib/weatherman'

describe Weatherman do
let(:weatherman) { Weatherman.new }

  describe "#forecast" do
    it "returns :sunny or :stormy" do
      allow(weatherman).to receive(:rand_number).and_return(0.1, 0.8)
      expect(weatherman.forecast).to eq(:sunny)
      expect(weatherman.forecast).to eq(:stormy)
    end
  end
end

