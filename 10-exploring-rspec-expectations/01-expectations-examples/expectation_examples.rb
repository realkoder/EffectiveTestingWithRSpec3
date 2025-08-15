RSpec.describe 'Expectations' do
  context 'number division' do
    it 'is within ratio of 0.1 from Math::PI' do
      ratio = 22 / 7.0
      expect(ratio).to be_within(0.1).of(Math::PI)
    end
  end

  context 'number array' do
    it 'only odd numbers' do
      numbers = [13, 3, 99]
      expect(numbers).to all be_odd
    end
  end

  context 'alphabet chars' do
    it 'contains all 26 letters from a - z ' do
      # Creates range object inclusive
      alphabet = ('a'..'z').to_a
      expect(alphabet).to start_with('a').and end_with('z')
      expect(alphabet.length).to eq(26)
    end
  end

  context 'a deck of card' do
    it 'contains 52 cards' do
      Deck = Struct.new(:cards)
      deck = Deck.new((1..52).to_a)
      expect(deck.cards.count).to eq(52), 'not playing with a full deck'
    end
  end
end

