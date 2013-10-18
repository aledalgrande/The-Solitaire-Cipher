class SolitaireCipher
  
  def self.encrypt(message)
    filtered_string = message.upcase.gsub(/[^A-Z]/,'').strip
    padded_string_array = filtered_string.scan(/.....|....|...|..|./)
    padded_string_array << padded_string_array.pop + 'X' * (5 - padded_string_array.size) if padded_string_array.last.size < 5
    padded_string_array.join(' ')
  end

end