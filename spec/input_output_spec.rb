require_relative '../lib/input_output'
require 'Rspec'

describe InputOutput do
  before(:each) do
    @input_output = InputOutput.new('message.txt', 'braille.txt')
  end
  it 'exists' do
    expect(@input_output).to be_an_instance_of(InputOutput)
  end

  it 'has readable attributes' do
    expect(@input_output.incoming_text).to be_a(File)
    expect(@input_output.outgoing_text).to be_a(File)
  end

end
