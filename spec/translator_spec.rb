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
    expect(@translator.translated_hash).to eq({})
  end

  it 'can translate given character into braille' do
    expect(@translator.translate("a")).to eq({top: "0.", mid: "..", bot: ".."})
  end

  it 'can format braille to print on three lines' do
    @translator.translate('a')
    expect(@translator.format).to eq(["0.\n", "..\n", "..\n"])
  end
end
