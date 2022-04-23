require_relative '../lib/translator'
require 'Rspec'

describe Translator do
  before(:each) do
    @translator = Translator.new
  end
  it 'exists' do
    expect(@translator).to be_an_instance_of(Translator)
  end
end
