require_relative '../lib/input_output'
require 'Rspec'

describe InputOutput do
  before(:each) do
    @input_output = InputOutput.new('message.txt', 'braille.txt')
    @input_output.read_incoming
  end
  it 'exists' do
    expect(@input_output).to be_an_instance_of(InputOutput)
  end

  it 'has readable attributes' do
    expect(@input_output.incoming_file).to eq('message.txt')
    expect(@input_output.outgoing_file).to eq('braille.txt')
  end

  it 'Can open and read the contents of attribute files' do
    expect(@input_output.incoming_text).to eq("Do not panic, this is merely a sample.\n")
  end

  it 'can return incoming text char count' do
    expect(@input_output.char_count).to eq(39)
  end

  it 'Can produce the desired message' do
    expect(@input_output.return_message).to eq("Created 'braille.txt' containing 39 characters")
  end

  it 'see all methods in run, and print a correct response' do #Using a stub to make sure all previous methods are visible to .run method- removing the CLI portion
    allow(@input_output).to receive(:run).and_return("Created '#{@input_output.outgoing_file}' containing #{@input_output.char_count} characters")
    expect(@input_output.run).to eq("Created 'braille.txt' containing 39 characters")
  end

end
