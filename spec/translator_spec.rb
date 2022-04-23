require_relative '../lib/translator'
require 'Rspec'
require 'CSV'

describe Translator do
  before(:each) do
    @translator = Translator.from_csv('./docs/dictionary.csv')
  end
  it 'exists' do
    expect(@translator).to be_an_instance_of(Translator)
  end

  it 'has readable attributes' do
    expect(@translator.dictionary).to be_an_instance_of(CSV::Table)
    expect(@translator.dictionary_hash).to eq({})
  end

  it 'can update the CSV hash based off dictionary' do
    @translator.update_hash
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

  it 'can translate given character into braille' do
    @translator.update_hash
    expect(@translator.translate("a")).to eq(['0.', '..', '..'])
  end

  it 'can format braille to print on three lines' do
    @translator.update_hash
    @translator.translate('a')
    @translator.format
    expect(@translator.translated_array).to eq(['0.\n', '..\n', '..\n'])
  end
end
