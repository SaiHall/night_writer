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
    expect(@translator.csv_hash).to eq({})
  end
end
