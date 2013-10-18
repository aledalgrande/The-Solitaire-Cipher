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

  end

end