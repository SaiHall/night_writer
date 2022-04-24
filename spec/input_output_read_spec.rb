require_relative '../lib/input_output_read'
require 'Rspec'
require 'CSV'

describe InputOutputRead do
    before(:each) do
        @io_read = InputOutputRead.new('braille.txt', 'original_message.txt')
    end

    it 'exists' do
      expect(@io_read).to be_an_instance_of(InputOutputRead)
    end
    it 'has readable attributes' do
      expect(@io_read.incoming_file).to eq('braille.txt')
      expect(@io_read.outgoing_file).to eq('original_message.txt')
    end

end
