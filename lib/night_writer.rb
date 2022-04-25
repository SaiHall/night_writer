require_relative './input_output'
input_output = InputOutput.new(ARGV[0], ARGV[1])
input_output.run
p input_output.return_message
