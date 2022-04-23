class InputOutput
  attr_reader :incoming_text, :outgoing_text

  def initialize(user_input1, user_input2)
    @incoming_text = File.new(user_input1, 'r')
    @outgoing_text = File.new(user_input2, 'w')
  end

end
