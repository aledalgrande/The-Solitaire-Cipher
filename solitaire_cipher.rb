class SolitaireCipher
  
  def self.encrypt(message)
    filtered_string = message.upcase.gsub(/[^A-Z]/,'').strip
    padded_string_array = filtered_string.scan(/.....|....|...|..|./)
    padded_string_array << padded_string_array.pop + 'X' * (5 - padded_string_array.size) if padded_string_array.last.size < 5  # pad the last one with Xs if needed
    padded_string_array.join(' ')
  end

  def self.deck
    # ordered deck
    base_deck

    # move A joker down one card
    move_card('A', 1)

    # move B joker down two cards
    move_card('B', 2)

    # perform a triple cut around the jokers: cards on top of the first go to the bottom of the second and viceversa; cards in between them don't move
    triple_cut

    # perform a count cut using the value of the bottom card: cut the bottom card's value in cards off the top of the deck and reinsert them just above the bottom card
    count_cut

    # Find the output letter: convert the top card to its value and count down that many cards from the top of the deck, with the top card itself being card number one; look at the card immediately after your count and convert it to a letter; if the output card is a joker, no letter is generated this sequence; this step does not alter the deck
    output_letter

    p @deck
  end

  def self.base_deck
    @deck = (1..52).to_a.map(&:to_s) + ['A', 'B']
  end

  def self.move_card(card, moves)
    index = @deck.index(card)
    size = @deck.size
    @deck.delete_at(index)
    new_index = (index + moves) % size
    @deck.insert(new_index.eql?(0) ? 1 : new_index, card)  # array is smaller now
  end

  def self.triple_cut
    top_deck, middle_deck, bottom_deck, passed_first_joker, passed_second_joker, first_joker, second_joker = [], [], [], false, false, nil, nil
    @deck.each do |card, idx|
      if card.eql?('A') || card.eql?('B')
        if passed_first_joker
          passed_second_joker = true
          second_joker = card
        else
          passed_first_joker = true
          first_joker = card
        end
      else
        if passed_second_joker
          bottom_deck << card
        elsif passed_first_joker
          middle_deck << card
        else
          top_deck << card
        end
      end
      @deck = bottom_deck + [first_joker] + middle_deck + [second_joker] + top_deck
    end
    @deck
  end

  def self.count_cut
    last = @deck.pop
    num = last.to_i
    @deck = @deck.slice(num, @deck.size - 1) + @deck.slice(0, num) + [last]
    # 1, 2, 4, 5, 3 => (5, 3,) num:last (1, 2, 4) 0:num-1
  end

end