require 'minitest/autorun'
require 'csv'

CSV::Converters[:format_temperature] = lambda{ |string|
  string.sub("*", "").to_i
}

class Day
  attr_reader :day_number

  def initialize(day_number:, max_temperature:, min_temperature:)
    @day_number      = day_number
    @max_temperature = max_temperature
    @min_temperature = min_temperature
  end

  def temperature_spread
    @_temperature_spread ||= max_temperature - min_temperature
  end

private
  attr_reader :max_temperature, :min_temperature
end

class Weather
  def initialize(data_file_path:)
    @data_file_path = data_file_path
  end

  def smallest_spread_day_number
    days.sort_by(&:temperature_spread).first.day_number
  end

private
  attr_reader :data_file_path

  def days
    CSV.read(data_file_path, csv_options).map do |row|
      Day.new(day_number: row["Dy"], max_temperature: row["MxT"], min_temperature: row["MnT"])
    end
  end

  def csv_options
    { col_sep: ' ', skip_blanks: true, headers: true, :converters => [:format_temperature] }
  end
end

class TestWeather < Minitest::Test
  def test_it
    assert(Weather.new(data_file_path: 'weather.dat').smallest_spread_day_number == 14)
  end
end