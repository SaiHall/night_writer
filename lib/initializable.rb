
module Initializable

  def read_incoming
    incoming = File.open(@incoming_file, "r")
    incoming_text = (incoming.read).chomp
    incoming.close
    return incoming_text.downcase
  end

  def update_hash
    dictionary_hash = {}
    @dictionary.each do |row|
      dictionary_hash[row[:character]] = {top: row[:braille][0..1], mid: row[:braille][2..3], bot: row[:braille][4..5]}
    end
    return dictionary_hash
  end

  def braille_hash
    braille_dict_hash = {}
    @dictionary.each do |row|
      braille_dict_hash[row[:braille]] = row[:character]
    end
    return braille_dict_hash
  end
end
