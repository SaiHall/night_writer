require_relative '../lib/input_output_read'
require 'Rspec'
require 'CSV'

describe InputOutputRead do
  it 'exists' do
    before(:each) do
        @io_read = InputOutputRead.new('braille.txt', 'original_message.txt')
    end
    expect(@io_read).to be_an_instance_of(InputOutputRead)
  end
end
