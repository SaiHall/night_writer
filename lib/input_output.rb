class InputOutput
  attr_reader :incoming_file, :outgoing_file, :incoming_text

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
    @incoming_text
  end

  def read_incoming
    incoming = File.open(@incoming_file, "r")
    @incoming_text = incoming.read
    incoming.close
  end

  def char_count
    @incoming_text.length
  end

  def return_message
    "Created '#{@outgoing_file}' containing #{char_count} characters"
  end

end
