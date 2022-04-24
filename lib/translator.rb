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

  def translate(text_to_translate)
    @translated_hash[:top] = @dictionary_hash[text_to_translate][:top]
    @translated_hash[:mid] = @dictionary_hash[text_to_translate][:mid]
    @translated_hash[:bot] = @dictionary_hash[text_to_translate][:bot]
    return @translated_hash
  end

  def format
    @translated_hash.each do |key, value|
      @translated_hash[key] = value + "\n"
    end
    return @translated_hash.values
  end
end
