require 'byebug'

class AirTrafficControl

  def initialize
    
    @masteroptions_txt = [
      'View list of planes.',
      'View list of airports.',
      'Land a plane at a given airport',
      'Fly a plane from a given airport',
      'Get statistics'
    ]
  end

#\/ \/ \/ \/ CONTROL PANEL \/ \/ \/ \/

  def display_options(options = @masteroptions_txt)
    options.each_with_index do |option_text, idx|
      puts "#{idx}: #{option_text}"
    end
  end

  def choose_option
    user_choice = gets.chomp
  end

#/\/\/\/\/ CONTROL PANEL /\/\/\/\/\/\

  def get_planes
    ObjectSpace.each_object(Plane).to_a
  end

  def get_flying_planes
    get_planes.select {|plane| plane.flying?}
  end

  def get_airports
    ObjectSpace.each_object(Airport).to_a
  end

  def get_plane_called(name)
    get_planes.select {|plane| plane.callsign == name}.sample
  end

  def get_airport_called(name)
    get_airports.select {|airport| airport.name == name}.sample
  end

  def planes_list
    list = []
    get_planes.each {|plane| list << plane.callsign }
    list
  end

  def flying_planes_list
    get_flying_planes.map {|plane| plane.callsign }
  end

  def airports_list
    get_airports.map {|airport| airport.name }
  end

  def launch_plane_from(options = {})
    airport = options[:airport]
    callsign = options[:callsign]
    launching_plane = airport.send_to_runway(callsign)
    airport.clear_for_takeoff(launching_plane)
  end

  def land_plane_at(options = {})
    plane = get_plane_called(options[:callsign])
    airport = get_airport_called(options[:airport_name])
    airport.clear_for_land(plane)
  end
end