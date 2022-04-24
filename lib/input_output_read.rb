class InputOutputRead

  attr_reader :incoming_file, :outgoing_file

  def initialize(user_input1, user_input2)
    @incoming_file = user_input1
    @outgoing_file = user_input2
  end

end
