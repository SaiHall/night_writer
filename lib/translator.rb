require_relative '../lib/input_output'
require 'CSV'
require_relative '../lib/initializable'

class Translator
  include Initializable
  attr_reader :dictionary, :dictionary_hash, :translated_hash

  def initialize(dictionary)
    @dictionary = dictionary
    @dictionary_hash = update_hash
    @translated_hash = {}

  end

  def self.from_csv(path)
    dictionary = CSV.read "#{path}", headers: true, header_converters: :symbol
    Translator.new(dictionary)
  end

  def translate(text_to_translate)#if statement for empty hash, and then to shovel into existing
    text_to_translate.each_char do |char|
      if @translated_hash == {}
        @translated_hash[:top] = @dictionary_hash[char][:top]
        @translated_hash[:mid] = @dictionary_hash[char][:mid]
        @translated_hash[:bot] = @dictionary_hash[char][:bot]
      else
        @translated_hash[:top] << @dictionary_hash[char][:top]
        @translated_hash[:mid] << @dictionary_hash[char][:mid]
        @translated_hash[:bot] << @dictionary_hash[char][:bot]
      end
    end
    return @translated_hash
  end

  def format
    @translated_hash.each do |key, value|
      @translated_hash[key] = value + "\n"
    end
    return @translated_hash.values
  end
end
