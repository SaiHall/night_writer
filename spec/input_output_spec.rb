require_relative '../lib/input_output'
require 'Rspec'

describe InputOutput do
  it 'exists' do
    input_output = InputOutput.new('message.txt', 'braille.txt')
    expect(input_output).to be_an_instance_of(InputOutput)
  end
end
