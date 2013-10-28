require File.join(File.dirname(__FILE__), '..', 'solitaire_cipher.rb')

describe SolitaireCipher do

  context "encrypt" do

    it "should discard any non A - Z characters" do
      SolitaireCipher.encrypt('I spent $400').should_not match(/\$/)
    end

    # it "should uppercase all the remaining letters" do
    #   SolitaireCipher.encrypt('I spent $400').should eq('ISPENT')
    # end

    it "should split the message into groups of 5 uppercase characters, adding Xs to the last group if necessary" do
      SolitaireCipher.encrypt('I spent $400').should eq('ISPEN TXXXX')
    end

    it "should generate a keystream letter for each letter" do
      fail
    end

  end

  context "keystream" do

    before(:each) do
      SolitaireCipher.base_deck      
    end

    it "should move a card" do
      SolitaireCipher.move_card('A', 1)
      SolitaireCipher.instance_variable_get(:@deck).should eq(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "B", "A"])
      SolitaireCipher.move_card('B', 2)
      SolitaireCipher.instance_variable_get(:@deck).should eq(["1", "B", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "A"])
    end

    it "should perform triple cut" do
      SolitaireCipher.move_card('A', 1)
      SolitaireCipher.move_card('B', 2)
      SolitaireCipher.triple_cut.should eq(["B", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "A", "1"])
    end

    it "should perform a count cut" do
      SolitaireCipher.move_card('A', 1)
      SolitaireCipher.move_card('B', 2)
      SolitaireCipher.triple_cut
      SolitaireCipher.count_cut.should eq(["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "A", "B", "1"])
    end

    it "should output a letter" do
      fail
    end

    it "should not output anything if the output card is a joker" do
      fail
    end
    
    it "should create an unkeyed deck" do
      SolitaireCipher.deck.first(10).should eq(['4', '49', '10', '53', '24', '8', '51', '44', '6', '4', '33'])
    end

    it "should generate a keystream" do
      fail
    end

  end

end