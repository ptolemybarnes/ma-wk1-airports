class Plane
attr_reader :status, :location, :callsign, :fuel_level, :fuel_capacity
DEFAULT_FUEL_CAPACITY = 10
FUEL_SAFETY_LIMIT = 4

  def initialize(options = {})
    @location      = options[:location]      || :sky
    @fuel_capacity = options[:fuel_capacity] || DEFAULT_FUEL_CAPACITY
    @fuel_level    = @fuel_capacity
    @status        = set_status
    @callsign      = create_call_sign
  end


  def takeoff
    raise 'Cannot take off. Plane is already airborne.' if flying?
    raise 'Cannot take off. Plane is low on fuel.' if low_fuel?
    @status, @location = :flying, :sky
  end

  def land(airport)
    raise 'Cannot land. Plane is already grounded.' unless flying?
    @status = :grounded
    @location = airport
  end

  def flying?
    status == :flying
  end

  private

  def set_status
    (@location == :sky ? :flying : :grounded)
  end

  def create_call_sign
    ('A'..'Z').to_a.sample + rand(10).to_s + rand(10).to_s
  end

  def low_fuel?
    fuel_level < FUEL_SAFETY_LIMIT
  end

end