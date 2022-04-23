require_relative '../lib/translator'
require 'Rspec'

describe Translator do
  before(:each) do
    @translator = Translator.new
  end
  it 'exists' do
    expect(@translator).to be_an_instance_of(Translator)
  end

  it 'has readable attributes' do
    expect(translator.dictionary_path).to eq('.docs/dictionary.csv')
  end
end
