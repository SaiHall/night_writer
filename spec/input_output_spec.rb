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
    expect(@input_output.incoming_file).to eq('message.txt')
    expect(@input_output.outgoing_file).to eq('braille.txt')
  end

  it 'Can open and read the contents of attribute files' do
    @input_output.read_incoming
    expect(@input_output.incoming_text).to eq("Do not panic, this is merely a sample.\n")
  end

  it 'can return incoming text char count' do
    @input_output.read_incoming
    expect(@input_output.char_count).to eq(39)
  end

end
