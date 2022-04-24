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
    @translator = Translator.from_csv('./docs/dictionary.csv')
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

  def write
    outgoing = File.open(@outgoing_file, "w")
    outgoing.write(@outgoing_text)
    outgoing.close
  end

  def run #Can update?
    puts return_message
  end

  def translate_incoming
    @translator.translate(@incoming_text)
    @translator.format
  end
end
