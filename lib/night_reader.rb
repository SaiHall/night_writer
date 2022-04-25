require_relative './input_output_read'
io_read = InputOutputRead.new(ARGV[0], ARGV[1])
io_read.run_braille
p io_read.return_message
