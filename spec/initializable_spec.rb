require_relative '../lib/translator'
require_relative '../lib/input_output'
require 'Rspec'
require 'CSV'

describe Initializable do
  it 'creates a hash from csv fed to Translator and sets it to dictionary_hash' do
    @translator = Translator.from_csv('./docs/dictionary.csv')

    expected = {" " => "......",
       "a" => "0.....",
       "b" => "0.0...",
       "c" => "00....",
       "d" => "00.0..",
       "e" => "0..0..",
       "f" => "000...",
       "g" => "0000..",
       "h" => "0.00..",
       "i" => ".00...",
       "j" => ".000..",
       "k" => "0...0.",
       "l" => "0.0.0.",
       "m" => "00..0.",
       "n" => "00.00.",
       "o" => "0..00.",
       "p" => "000.0.",
       "q" => "00000.",
       "r" => "0.000.",
       "s" => ".00.0.",
       "t" => ".0000.",
       "u" => ".0..00",
       "v" => "0.0.00",
       "w" => ".000.0",
       "x" => "00..00",
       "y" => "00.000",
       "z" => "0..000"}
    expect(@translator.dictionary_hash).to eq(expected)
  end

  it 'set the contents, without \n, of an incoming file to incoming text' do
    @input_output = InputOutput.new('message.txt', 'braille.txt')
    expect(@input_output.incoming_text).to eq("Do not panic, this is merely a sample.")
    @input_output = InputOutput.new('message_one_char.txt', 'braille.txt')
    expect(@input_output.incoming_text).to eq("d")
  end
end
