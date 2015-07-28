require 'minitest/autorun'

class Weather
  def initialize(data_file_path:)
    @data_file_path = data_file_path
  end

  def smallest_spread_day_number
  end
end

class TestWeather < Minitest::Test
  def test_it
    assert(Weather.new(data_file_path: 'weather.dat').smallest_spread_day_number == 9)
  end
end