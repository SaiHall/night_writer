require_relative '../lib/input_output'
require_relative '../lib/input_output_read'
require 'CSV'
require_relative '../lib/initializable'

class Translator
  include Initializable
  attr_reader :dictionary, :dictionary_hash, :braille_dict_hash, :translated_hash

  def initialize(dictionary)
    @dictionary = dictionary
    @dictionary_hash = update_hash
    @braille_dict_hash = braille_hash
    @translated_hash = {}
  end

  def self.from_csv(path)
    dictionary = CSV.read "#{path}", headers: true, header_converters: :symbol
    Translator.new(dictionary)
  end

  def translate(text_to_translate)
    text_to_translate.each_char do |char|
      if @translated_hash == {}
        @translated_hash[:top] = @dictionary_hash[char][:top]
        @translated_hash[:mid] = @dictionary_hash[char][:mid]
        @translated_hash[:bot] = @dictionary_hash[char][:bot]
      else
        @translated_hash[:top] += @dictionary_hash[char][:top]
        @translated_hash[:mid] += @dictionary_hash[char][:mid]
        @translated_hash[:bot] += @dictionary_hash[char][:bot]
      end
    end
    return @translated_hash
  end

  def translate_braille(character_to_translate)
    english_array = []
    if !character_to_translate.include?("\n")
      english_array << @braille_dict_hash[character_to_translate]
    else
      segments = character_to_translate.split("\n")
      until segments.join.length == 0 do
        english_array << "#{segments[0].slice!(0..1)}#{segments[1].slice!(0..1)}#{segments[2].slice!(0..1)}"
        segments.delete("")
      end
      english_array.map! { |element| element = @braille_dict_hash[element]}
    end
    return english_array.join
  end

  def format
    @translated_hash.each do |key, value|
      @translated_hash[key] = value + "\n"
    end
    return @translated_hash.values
  end
end
