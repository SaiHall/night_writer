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


end
