require_relative './translator'
require_relative './initializable'
class InputOutput
  include Initializable
  attr_reader :incoming_file, :outgoing_file, :incoming_text, :outgoing_text, :translator

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
    @incoming_text = read_incoming
    @outgoing_text
    @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
  end

  def char_count
    @incoming_text.length
  end

  def return_message
    "Created '#{@outgoing_file}' containing #{char_count} characters"
  end

  def set_outgoing_text(set_to_text)
    @outgoing_text = set_to_text
  end

  def translate_incoming
    @translator.translate(@incoming_text)
    @translator.format
  end

  def write_translation
    outgoing = File.open(@outgoing_file, "w")
    if @outgoing_text[0].length > 80
      until @outgoing_text[0].length < 80 do
        outgoing.write("#{@outgoing_text[0].slice!(0..79)}\n")
        outgoing.write("#{@outgoing_text[1].slice!(0..79)}\n")
        outgoing.write("#{@outgoing_text[2].slice!(0..79)}\n")
      end
      outgoing.write(@outgoing_text[0])
      outgoing.write(@outgoing_text[1])
      outgoing.write(@outgoing_text[2])
    else
      outgoing.write(@outgoing_text[0])
      outgoing.write(@outgoing_text[1])
      outgoing.write(@outgoing_text[2])
    end
    outgoing.close
  end

  def run
    set_outgoing_text(translate_incoming)
    write_translation
  end
end
