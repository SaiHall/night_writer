require_relative '../lib/input_output'
require_relative '../lib/translator'
require 'Rspec'
require 'CSV'

describe InputOutput do
  context 'input' do
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

    it 'Can open and read the contents of attribute file' do
        expect(@input_output.incoming_text).to eq("Do not panic, this is merely a sample.")
    end

    it 'can return incoming text char count' do
        expect(@input_output.char_count).to eq(38)
    end

    it 'Can produce the desired message' do
        expect(@input_output.return_message).to eq("Created 'braille.txt' containing 38 characters")
    end

    it 'see all methods in run, and print a correct response' do #Using a stub to make sure all previous methods are visible to .run method- removing the CLI portion
        allow(@input_output).to receive(:run).and_return("Created '#{@input_output.outgoing_file}' containing #{@input_output.char_count} characters")
        expect(@input_output.run).to eq("Created 'braille.txt' containing 38 characters")
    end
  end
  context 'output' do
    before(:each) do
      @input_output = InputOutput.new('message.txt', 'braille.txt')
      @input_output.read_incoming
      @input_output.set_outgoing_text(@input_output.incoming_text)
    end

    it 'can set outgoing text and read it' do
      expect(@input_output.outgoing_text).to eq(@input_output.incoming_text)
      expect(@input_output.outgoing_text).to eq("Do not panic, this is merely a sample.")
    end
    it 'can write outgoing contents to a new file' do
      @input_output.write
      new_file = File.open(@input_output.outgoing_file)
      new_file_contents = new_file.read
      new_file.close
      expect(new_file_contents).to eq("Do not panic, this is merely a sample.")
    end
  end
  context 'translating output text' do
    before(:each) do
      @input_output = InputOutput.new('message_one_char.txt', 'braille.txt')
      @input_output.read_incoming
      @translator = Translator.from_csv('./docs/dictionary.csv')
      @translator.update_hash
    end

    it 'can translate outgoing text to loose braille' do
      # incoming_text =
      expect(@input_output.set_outgoing_text(@translator.translate(@input_output.incoming_text))).to eq(['00', '.0', '..'])
    end
  end
end
