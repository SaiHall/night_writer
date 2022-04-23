require_relative '../lib/input_output'
require 'CSV'

class Translator
  attr_reader :dictionary, :csv_hash

  def initialize(dictionary)
    @dictionary = dictionary
    @csv_hash = {}
  end

  def self.from_csv(path)
    dictionary = CSV.read "#{path}", headers: true, header_converters: :symbol
    Translator.new(dictionary)
  end

  def update_hash#move to module to keep in init?
    @dictionary.each do |row|
      @csv_hash[row[:character]] = row[:braille]
    end
  end

  def translate(text_to_translate)
    array = []
    array << @csv_hash[text_to_translate][0..1]
    array << @csv_hash[text_to_translate][2..3]
    array << @csv_hash[text_to_translate][4..5]
  end
end
