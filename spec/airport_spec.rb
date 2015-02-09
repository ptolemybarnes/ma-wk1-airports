require './lib/airport'
require './lib/weatherman'

describe Airport do
let(:airport) { Airport.new }
let(:stormyairport) { Airport.new(weather: :stormy)}
let(:weatherman) { double( :weatherman, forecast: :stormy)}
let(:plane) { double( :plane, land: nil , takeoff: nil, callsign: 'X12')}

  describe "on creation" do
    subject(:incheon) { Airport.new(name: "Incheon") }
    
    it "has location name" do
      expect(incheon.name).to match /Incheon/
    end
    it "has default plane capacity" do
      expect(incheon.capacity).to eq(10)
    end
    it "has default weather conditions" do
      expect(incheon.weather).to eq(:sunny)
    end
    it "has a day of 0" do
      expect(incheon.day).to be_zero 
    end
    it 'has an airport name' do
      expect(airport.name).to be_a_kind_of(String)
    end
    context 'when an endowment of planes is passed' do
      it "10 stores 10 planes" do
      airport = Airport.new(endowment: 10)
      expect(airport.plane_count).to eq(10)
      end
      it '1 stores 1 plane' do
      airport = Airport.new(endowment: 1)
      expect(airport.plane_count).to eq(1)
      end
    end
    context 'when no endowment is passed' do
      it '#plane_count returns 0' do
        expect(airport.plane_count).to eq(0)
      end
    end
  end

  describe "#nextday" do

    it "advances day by 1" do
      airport.next_day
      expect(airport.day).to eq(1)
    end
    it "gets new forecast from weatherman" do
      airport.next_day(weatherman.forecast)
      expect(airport.weather).to eq(:stormy)
    end
  end

  describe "#clear_for_land" do
    context 'when :sunny' do
      it "stores plane in @hanger" do
        airport.clear_for_land(plane)
        expect(airport.plane_count).to eq(1)
      end
    end
    context 'when :stormy' do
      it 'returns an error' do
        expect(lambda { stormyairport.clear_for_land(plane)} ).to raise_error('Danger! Plane cannot land during a storm.')
      end
      it "does not store plane in @hanger" do
        airport.clear_for_land(plane)
      end
    end
    context 'when airport is full.' do
      it 'returns an error if plane tries to land' do
        expect( lambda { full_airport.clear_for_land(plane) }).to raise_error('Landing request denied: airport is full.')
      end
    end
  end

  describe "#clear_for_takeoff" do
    context 'when :sunny' do
      it "removes plane from hanger" do
        airport = Airport.new(endowment: 1)
        airport.clear_for_takeoff
        expect(airport.plane_count).to eq(0)
      end
    end
    context 'when :stormy' do
      it "returns an error" do
        expect(lambda{ stormyairport.clear_for_takeoff(plane) }).to raise_error('Danger! Plane cannot takeoff during a storm.')
      end
    end
  end
  describe '#send_to_runway' do
    it 'returns the plane with matching callsign' do
      airport = Airport.new(endowment: 1)
      expected_callsign = airport.hangar.sample.callsign
      plane = airport.send_to_runway(expected_callsign)
      expect(plane.callsign).to eq(expected_callsign)
    end
  end
  it '#full? returns true if plane_count == @capacity' do
    expect(full_airport.full?).to eq(true)
  end
end

def full_airport
  Airport.new(endowment: 10, capacity: 10)
end



