require_relative '../lib/input_output_read'
require 'Rspec'
require 'CSV'

describe InputOutputRead do
  context 'set up of new io class' do
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

    it 'Can open and read the contents of attribute file' do
        expect(@io_read.incoming_text).to eq(".00.0....00.0.0.00..0.0.0.00\n0000.0..00.00.0..0..0..0...0\n0...........0.0.00........0.")
    end
  end

  context 'Counting characters from braille' do
    it 'can count braille characters' do
      expect(@io_read.braille_count).to eq(14)
    end
  end
end
