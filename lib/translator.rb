require_relative '../lib/input_output'
require 'CSV'

class Translator
  attr_reader :dictionary, :dictionary_hash, :translated_array

  def initialize(dictionary)
    @dictionary = dictionary
    @dictionary_hash = {}
    @translated_array = []

  end

  def self.from_csv(path)
    dictionary = CSV.read "#{path}", headers: true, header_converters: :symbol
    Translator.new(dictionary)
  end

  def update_hash#move to module to keep in init?
    @dictionary.each do |row|
      @dictionary_hash[row[:character]] = row[:braille]
    end
  end

  def translate(text_to_translate)
    @translated_array << @dictionary_hash[text_to_translate][0..1]
    @translated_array << @dictionary_hash[text_to_translate][2..3]
    @translated_array << @dictionary_hash[text_to_translate][4..5]
  end

  def format
    @translated_array.map do |element|
      element << '\n'
    end
  end
end
