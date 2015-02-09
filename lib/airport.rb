require './lib/weatherman'
require './lib/plane'

class Airport
  attr_reader :name, :capacity, :weather, :day, :hangar
  DEFAULT_CAPACITY = 10

  def initialize(options = {})
    @name = options[:name] || File.readlines('./lib/airport-codes.txt').sample.chomp
    @capacity = options[:capacity] || DEFAULT_CAPACITY
    @weather = options[:weather] || :sunny
    endowment = options[:endowment] || 0

    @day = 0
    @hangar = []
    fill_hangar(endowment)
  end

  def fill_hangar(endowment)
    endowment.times { @hangar << Plane.new(status: :grounded, location: self) }
  end

  def plane_count
    @hangar.count
  end

  def full?
    plane_count == @capacity
  end

  def next_day(forecast = :sunny)
    @day = @day.next
    @weather = forecast
  end

  def send_to_runway(callsign)
    @hangar.select {|plane| plane.callsign == callsign }.sample
  end

  def clear_for_land(plane)
    raise 'Danger! Plane cannot land during a storm.' if @weather == :stormy
    raise 'Landing request denied: airport is full.' if full?
    plane.land(self)
    @hangar << plane
  end

  def clear_for_takeoff(plane = @hangar.first)
    raise 'Danger! Plane cannot takeoff during a storm.' if @weather == :stormy
    plane.takeoff
    @hangar.delete(plane)
  end
end