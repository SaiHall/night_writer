require_relative '../lib/input_output'
require_relative '../lib/translator'
require 'Rspec'
require 'CSV'

describe InputOutput do
  context 'input' do
    before(:each) do
        @input_output = InputOutput.new('message.txt', 'message_repeat.txt')
    end
    it 'exists' do
        expect(@input_output).to be_an_instance_of(InputOutput)
    end

    it 'has readable attributes' do
        expect(@input_output.incoming_file).to eq('message.txt')
        expect(@input_output.outgoing_file).to eq('message_repeat.txt')
    end

    it 'Can open and read the contents of attribute file, in lowercase' do
        expect(@input_output.incoming_text).to eq("do not panic, this is merely a sample.")
    end

    it 'can return incoming text char count' do
        expect(@input_output.char_count).to eq(38)
    end

    it 'Can produce the desired message' do
        expect(@input_output.return_message).to eq("Created 'message_repeat.txt' containing 38 characters")
    end
  end

  context 'output' do
    before(:each) do
      @input_output = InputOutput.new('message.txt', 'message_repeat.txt')
      @input_output.set_outgoing_text(@input_output.incoming_text)
    end

    it 'can set outgoing text and read it' do
      expect(@input_output.outgoing_text).to eq(@input_output.incoming_text)
      expect(@input_output.outgoing_text).to eq("do not panic, this is merely a sample.")
    end
  end

  context 'translating output text' do
    before(:each) do
      @input_output = InputOutput.new('message_one_char.txt', 'braille_one_char.txt')
      @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
    end

    it 'can set translated, formatted braille to outgoing text' do
      @translator.translate(@input_output.incoming_text)
      @input_output.set_outgoing_text(@translator.format)
      expect(@input_output.outgoing_text).to eq(["00\n", ".0\n", "..\n"])
    end

    it 'can translate incoming text from within input output class' do
      expect(@input_output.translate_incoming).to eq(["00\n", ".0\n", "..\n"])
    end

    it 'can set translated incoming text as out going text' do
      @input_output.set_outgoing_text(@input_output.translate_incoming)
      expect(@input_output.outgoing_text).to eq(["00\n", ".0\n", "..\n"])
    end
  end

  context 'writing translated character to a new file' do
    before(:each) do
      @input_output = InputOutput.new('message_one_char.txt', 'braille_one_char.txt')
      @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
    end

    it 'can write formatted text translation to new file' do
      @input_output.set_outgoing_text(@input_output.translate_incoming)
      @input_output.write_translation
      new_file = File.open(@input_output.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("00\n.0\n..\n")
    end
  end

  context 'Writing/Translating more than one character' do
    before(:each) do
      @input_output = InputOutput.new('message_simple.txt', 'braille_multi.txt')
      @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
      @input_output.set_outgoing_text(@input_output.translate_incoming)
      @input_output.write_translation
    end

    it 'can translate multiple characters' do
      expect(@input_output.outgoing_text).to eq([".00.0....00.0.0.00..0.0.0.00\n", "0000.0..00.00.0..0..0..0...0\n", "0...........0.0.00........0.\n"])
    end

    it 'can write multiple characters in braille' do
      new_file = File.open(@input_output.outgoing_file)
      new_file_contents = new_file.readlines
      new_file.close
      expect(new_file_contents).to eq([".00.0....00.0.0.00..0.0.0.00\n", "0000.0..00.00.0..0..0..0...0\n", "0...........0.0.00........0.\n"])
    end
  end

  context 'Writing/Translating more than 40 characters' do
    before(:each) do
      @input_output = InputOutput.new('message_long.txt', 'braille_long.txt')
      @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
      @input_output.set_outgoing_text(@input_output.translate_incoming)
      @input_output.write_translation
    end

    it 'can translate more that 40 characters with correct formatting' do
      new_file = File.open(@input_output.outgoing_file)
      new_file_contents = new_file.readlines
      new_file.close
      expected = [".00.0.0.0...000..0..0.0.0....0.00.0..00.0.0.0..0...00.0.0.00...000..0.0..00....0\n",
       "0000.000.0...0.0......00.0..0.00.0.00000.0..0000..0..00000.0..0.....0...00.0..0.\n",
       "0.....0.....000.00....0.....0..0....0.......0.0...0.0.0.0.00....0...0...0.......\n",
       "...00..0..0.0.0.0..00000..0.0.0.0.00.00.0.0.0...000.0...000..0\n",
       "..00..0...0..0.0..0..000...00..000.00000.000.0..0..000...0.0..\n",
       "...0..0...0.0.0.0...0.......00..0.00.0....0.......0.0...000.00\n"]
      expect(new_file_contents).to eq(expected)
    end
  end
  context 'Run testing' do
    before(:each) do
      @input_output = InputOutput.new('message_long.txt', 'braille_long.txt')
    end

    it 'can translate and write in one method containing all set up' do
      @input_output.run
      new_file = File.open(@input_output.outgoing_file)
      new_file_contents = new_file.readlines
      new_file.close
      expected = [".00.0.0.0...000..0..0.0.0....0.00.0..00.0.0.0..0...00.0.0.00...000..0.0..00....0\n",
       "0000.000.0...0.0......00.0..0.00.0.00000.0..0000..0..00000.0..0.....0...00.0..0.\n",
       "0.....0.....000.00....0.....0..0....0.......0.0...0.0.0.0.00....0...0...0.......\n",
       "...00..0..0.0.0.0..00000..0.0.0.0.00.00.0.0.0...000.0...000..0\n",
       "..00..0...0..0.0..0..000...00..000.00000.000.0..0..000...0.0..\n",
       "...0..0...0.0.0.0...0.......00..0.00.0....0.......0.0...000.00\n"]
      expect(new_file_contents).to eq(expected)
    end
  end
end
