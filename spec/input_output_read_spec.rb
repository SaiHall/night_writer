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

  context 'Counting characters from braille & confirmation message' do
    before(:each) do
        @io_read = InputOutputRead.new('braille.txt', 'original_message.txt')
    end

    it 'can count braille characters' do
      expect(@io_read.braille_count).to eq(14)
    end

    it 'can return a message with count and file name to be created' do
      expect(@io_read.return_message).to eq("Created 'original_message.txt' containing 14 characters.")
    end
  end
  context 'Create dictionary for braille to english, write translation' do
    before(:each) do
        @io_read = InputOutputRead.new('braille_one_char.txt', 'original_message.txt')
    end

    it 'has a translator' do
      expect(@io_read.translator).to be_a(Translator)
    end

    it 'can translate a character from a read file' do
      expect(@io_read.incoming_text).to eq("00\n.0\n..")
      expect(@io_read.translate_incoming_braille).to eq("d")
    end

    it 'can set outgoing text' do
      @io_read.set_outgoing_text(@io_read.translate_incoming_braille)
      expect(@io_read.outgoing_text).to eq("d")
    end

    it 'can write translated braille in english in new file' do
      @io_read.set_outgoing_text(@io_read.translate_incoming_braille)
      @io_read.write_braille_translation
      new_file = File.open(@io_read.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("d")
    end
  end

  context 'Write translation to new file for multiple characters' do
    before(:each) do
        @io_read = InputOutputRead.new('braille_multi.txt', 'original_message.txt')
    end

    it 'can translate multiple characters at once' do
      expect(@io_read.incoming_text).to eq(".00.0....00.0.0.00..0.0.0.00\n0000.0..00.00.0..0..0..0...0\n0...........0.0.00........0.")
      expect(@io_read.translate_incoming_braille).to eq("the jelly bean")
    end

    it 'can write translated braille to a file in english' do
      @io_read.set_outgoing_text(@io_read.translate_incoming_braille)
      @io_read.write_braille_translation
      new_file = File.open(@io_read.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("the jelly bean")
    end
  end

  context 'Write translation to new file for more than 40 characters' do
    before(:each) do
        @io_read = InputOutputRead.new('braille_long.txt', 'original_message.txt')
    end

    it 'can translate more than 40 characters' do
      expect(@io_read.translate_incoming_braille).to eq("there you are sweetheart sorry im late i was looking everywhere for you")
    end

    it 'can write translated long braile to a file in english' do
      @io_read.set_outgoing_text(@io_read.translate_incoming_braille)
      @io_read.write_braille_translation
      new_file = File.open(@io_read.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("there you are sweetheart sorry im late i was looking everywhere for you")
    end
  end
  context 'Run testing' do
    it 'can translate and write in one method containing all set up' do
      io_read = InputOutputRead.new('braille_long.txt', 'original_message.txt')
      io_read.run_braille
      new_file = File.open(io_read.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("there you are sweetheart sorry im late i was looking everywhere for you")
    end
  end
end
