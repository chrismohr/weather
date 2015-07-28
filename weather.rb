require 'minitest/autorun'
require 'csv'

CSV::Converters[:format_temperature] = lambda{ |string|
  string.sub("*", "").to_i
}

class Weather
  def initialize(data_file_path:)
    @data_file_path = data_file_path
  end

  def smallest_spread_day_number
    max_diff = 0
    max_diffs = []
    CSV.foreach(data_file_path, csv_options) do |row|
      diff = row["MxT"] - row["MnT"]
      if diff > max_diff
        max_diff = diff
        max_diffs << row["Dy"]
      end
    end
    max_diffs.last
  end

private
  attr_reader :data_file_path

  def csv_options
    { col_sep: ' ', skip_blanks: true, headers: true, :converters => [:format_temperature] }
  end
end

class TestWeather < Minitest::Test
  def test_it
    assert(Weather.new(data_file_path: 'weather.dat').smallest_spread_day_number == 9)
  end
end