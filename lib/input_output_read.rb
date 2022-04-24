require_relative './initializable'


class InputOutputRead
  include Initializable

  attr_reader :incoming_file, :outgoing_file, :incoming_text

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
    @incoming_text = read_incoming
  end

  def braille_count
    (@incoming_text.delete("\n").length) / 6
  end

end
