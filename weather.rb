require 'minitest/autorun'
require 'csv'

class Weather
  def initialize(data_file_path:)
    @data_file_path = data_file_path
  end

  def smallest_spread_day_number
    CSV.foreach(data_file_path, csv_options) do |row|
      max = row["MxT"].sub("*", "").to_i
      min = row["MnT"].sub("*", "").to_i
      diff = max - min
    end
  end

private
  attr_reader :data_file_path

  def csv_options
    { col_sep: ' ', skip_blanks: true, headers: true }
  end
end

class TestWeather < Minitest::Test
  def test_it
    assert(Weather.new(data_file_path: 'weather.dat').smallest_spread_day_number == 9)
  end
end