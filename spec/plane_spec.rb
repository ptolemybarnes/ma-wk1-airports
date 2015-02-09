require './lib/plane'

describe Plane do
  let(:plane)         { Plane.new                        }
  let(:groundedplane) { Plane.new(location: :airport) }
  let(:airport)       { double(:airport)                 }

  describe 'on creation' do 

    it 'has default location of :sky' do
      expect(plane.location).to eq(:sky)
    end

    it 'has a default fuel level' do
      expect(plane.fuel_level).to be(Plane::DEFAULT_FUEL_CAPACITY)
    end

    it 'can have a fuel capacity of 20' do
      plane = Plane.new(fuel_capacity: 20)
      expect(plane.fuel_level).to eq(20)
    end

    it "knows when it's low on fuel" do
      allow(plane).to receive(:fuel_level).and_return(1)
      expect(plane.send(:low_fuel?)).to be true
    end

    context 'when @location defaults to :sky' do

      it '@status defaults to :flying' do
        expect(plane.status).to eq(:flying)
      end

    end
    
    context 'when Plane.new is passed an airport' do
      it '@status defaults to :grounded' do
        expect(groundedplane.status).to eq(:grounded)
      end
      it '#location returns :stormyairport when Plane.new is passed location: stormyairport.' do
        plane = Plane.new(location: :stormyairport)
        expect(plane.location).to be(:stormyairport)
      end
    end
  end

  describe '#takeoff' do
    it "changes @status to :flying" do
      groundedplane.takeoff
      expect(groundedplane.status).to eq(:flying)
    end
    it "sets @location to :sky" do
      groundedplane.takeoff
      expect(groundedplane.location).to eq(:sky)
    end
    it 'raises error if plane is already flying' do
      expect( lambda { plane.takeoff }).to raise_error('Cannot take off. Plane is already airborne.')
    end
    it 'raises an error if plane is low on fuel' do
      allow(groundedplane).to receive(:low_fuel?).and_return(true)
      expect( lambda { groundedplane.takeoff }).to raise_error('Cannot take off. Plane is low on fuel.')
    end
  end
  
  describe '#land' do
    it "changes @status to :ground" do
      plane.land(airport)
      expect(plane.status).to eq(:grounded)
    end
    it 'sets @location to an airport object' do
      plane.land(airport)
      expect(plane.location).to be(airport)
    end
    it 'raises error if plane is already :grounded' do
      expect( lambda { groundedplane.land(airport) }).to raise_error('Cannot land. Plane is already grounded.')
    end
  end
end
