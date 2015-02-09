
class Weatherman
  
  def forecast
    case rand_number
    when (0..0.7)
      :sunny
    when (0.7...1)
      :stormy
    end
  end

  def rand_number
    rand
  end

end