require './lib/atc'
require './lib/airport'
require './lib/weatherman'
require './lib/plane'

# describe 'Finale' do
#   it 'finale' do
#     ObjectSpace.garbage_collect
#     heathrow = Airport.new(name: 'Heathrow')
#     atc = AirTrafficControl.new
#     6.times { Plane.new }
#     atc.flying_planes_list.each do |plane_callsign|
#       atc.land_plane_at(callsign: plane_callsign, airport: 'Heathrow')
#     end
#     expect(heathrow.plane_count).to eq(6)
#     expect(atc.get_planes.select {|plane| plane.status == :grounded}.count).to eq(6)
#   end
# end


describe AirTrafficControl do

let(:atc) { AirTrafficControl.new }
let(:airport) { Airport.new }
let(:weatherman) { Weatherman.new }
let(:plane) { Plane.new }

  describe 'on creation' do
    it '#new creates new object' do
      atc = AirTrafficControl.new
    end
  end

  it 'generates [array] of plane callsigns' do
    expect(atc.planes_list).to be_a_kind_of(Array)
  end
  it 'generates [array] of airports' do
    expect(atc.airports_list).to be_a_kind_of(Array)
  end

  describe 'get_plane_called' do
    it 'gets a plane by callsign' do
      plane = Plane.new
      expect(atc.get_plane_called(plane.callsign)).to be(plane)
    end
  end

  it '#launch_plane' do
    airport = Airport.new(endowment: 1)
    atc.launch_plane_from(airport: airport, callsign: airport.hangar.first.callsign)
    expect(airport.plane_count).to eq(0)
  end

  it 'can land a plane at an airport specified by a name' do
    plane = Plane.new
    airport = Airport.new(name: 'Heathrow')
    atc.land_plane_at airport_name: airport.name, callsign: plane.callsign
    expect(airport.plane_count).to eq(1)
  end

  describe 'flying_planes_list' do
    it 'returns callsigns of flying planes' do
      expect(atc.flying_planes_list).to be_a_kind_of(Array)
    end
  end
end






