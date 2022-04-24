require_relative '../lib/translator'
require_relative '../lib/input_output'
require 'Rspec'
require 'CSV'

describe Initializable do
  it 'creates a hash from csv fed to Translator and sets it to dictionary_hash' do
    @translator = Translator.from_csv('./docs/dictionary.csv')

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

  it 'set the contents, without \n, of an incoming file to incoming text' do
    @input_output = InputOutput.new('message.txt', 'braille.txt')
    expect(@input_output.incoming_text).to eq("Do not panic, this is merely a sample.")
    @input_output = InputOutput.new('message_one_char.txt', 'braille.txt')
    expect(@input_output.incoming_text).to eq("d")
  end
end
