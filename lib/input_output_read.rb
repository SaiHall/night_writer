require_relative './translator'
require_relative './initializable'

class InputOutputRead
  include Initializable

  attr_reader :incoming_file, :outgoing_file, :incoming_text, :translator, :outgoing_text

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
    @incoming_text = read_incoming
    @translator = Translator.from_csv('./docs/eng_to_braille_dict.csv')
    @outgoing_text
  end

  def braille_count
    (@incoming_text.delete("\n").length) / 6
  end

  def return_message
    "Created '#{@outgoing_file}' containing #{braille_count} characters."
  end

  def translate_incoming_braille
    @translator.translate_braille(@incoming_text)
  end

  def set_outgoing_text(text_to_set)
    @outgoing_text = text_to_set
  end

  def write_braille_translation
    outgoing = File.open(@outgoing_file, "w")
    outgoing.write(@outgoing_text)
    outgoing.close
  end

  def run_braille
    set_outgoing_text(translate_incoming_braille)
    write_braille_translation
  end
end
