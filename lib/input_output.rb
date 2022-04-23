class InputOutput
  attr_reader :incoming_file, :outgoing_file, :incoming_text, :outgoing_text

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
    @incoming_text
    @outgoing_text
  end

  def read_incoming #Make a module to put .read_incoming in intialize?
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

  def set_outgoing_text(set_to_text)
    @outgoing_text = set_to_text
  end

  def write
    outgoing = File.open(@outgoing_file, "w")
    outgoing.write(@outgoing_text)
    outgoing.close
  end

  def run
    read_incoming
    puts return_message
  end
end
