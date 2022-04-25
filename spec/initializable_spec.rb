require_relative '../lib/translator'
require_relative '../lib/input_output'
require 'Rspec'
require 'CSV'

describe Initializable do
  it 'creates a hash from csv fed to Translator and sets it to dictionary_hash' do
    @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')

    expected = {" " => {top: "..", mid: "..", bot: ".."},
       "a" => {top:"0.", mid: "..", bot: ".."},
       "b" => {top:"0.", mid: "0.", bot: ".."},
       "c" => {top:"00", mid: "..", bot: ".."},
       "d" => {top:"00", mid: ".0", bot: ".."},
       "e" => {top:"0.", mid: ".0", bot: ".."},
       "f" => {top:"00", mid: "0.", bot: ".."},
       "g" => {top:"00", mid: "00", bot: ".."},
       "h" => {top:"0.", mid: "00", bot: ".."},
       "i" => {top:".0", mid: "0.", bot: ".."},
       "j" => {top:".0", mid: "00", bot: ".."},
       "k" => {top:"0.", mid: "..", bot: "0."},
       "l" => {top:"0.", mid: "0.", bot: "0."},
       "m" => {top:"00", mid: "..", bot: "0."},
       "n" => {top:"00", mid: ".0", bot: "0."},
       "o" => {top:"0.", mid: ".0", bot: "0."},
       "p" => {top:"00", mid: "0.", bot: "0."},
       "q" => {top:"00", mid: "00", bot: "0."},
       "r" => {top:"0.", mid: "00", bot: "0."},
       "s" => {top:".0", mid: "0.", bot: "0."},
       "t" => {top:".0", mid: "00", bot: "0."},
       "u" => {top:".0", mid: "..", bot: "00"},
       "v" => {top:"0.", mid: "0.", bot: "00"},
       "w" => {top:".0", mid: "00", bot: ".0"},
       "x" => {top:"00", mid: "..", bot: "00"},
       "y" => {top:"00", mid: ".0", bot: "00"},
       "z" => {top:"0.", mid: ".0", bot: "00"}}
    expect(@translator.dictionary_hash).to eq(expected)
  end

  it 'set the contents, without \n, of an incoming file to incoming text in lowercase' do
    @input_output = InputOutput.new('message.txt', 'braille.txt')
    expect(@input_output.incoming_text).to eq("do not panic, this is merely a sample.")
    @input_output = InputOutput.new('message_one_char.txt', 'braille_one_char.txt')
    expect(@input_output.incoming_text).to eq("d")
  end

  it 'can create another dictionary for braille to english' do
    @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
    expected = {"0....."=>"a",
      "0.0..."=>"b",
      "00...."=>"c",
      "00.0.."=>"d",
      "0..0.."=>"e",
      "000..."=>"f",
      "0000.."=>"g",
      "0.00.."=>"h",
      ".00..."=>"i",
      ".000.."=>"j",
      "0...0."=>"k",
      "0.0.0."=>"l",
      "00..0."=>"m",
      "00.00."=>"n",
      "0..00."=>"o",
      "000.0."=>"p",
      "00000."=>"q",
      "0.000."=>"r",
      ".00.0."=>"s",
      ".0000."=>"t",
      ".0..00"=>"u",
      "0.0.00"=>"v",
      ".000.0"=>"w",
      "00..00"=>"x",
      "00.000"=>"y",
      "0..000"=>"z",
      "......"=>" "}
    expect(@translator.braille_dict_hash).to eq(expected)
  end
end
