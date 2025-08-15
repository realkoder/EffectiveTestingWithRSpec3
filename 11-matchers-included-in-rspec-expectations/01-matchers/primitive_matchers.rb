RSpec.describe 'Primitive Matchers' do
  context 'square root of 9' do
    it 'is 3' do
      expect(Math.sqrt(9)).to eq(3)
    end
  end

  context 'Perms first try' do
    it 'should equal second try' do
      Permutations = Struct.new do
        def of(list)
          shuffled_list = list.shuffle
          @permutation_list ||= shuffled_list
        end
      end
      long_word_list = ['a', 'b', 'efef']
      perms = Permutations.new
      first_try = perms.of(long_word_list)
      second_try = perms.of(long_word_list)
      expect(second_try).to eq(first_try)
      expect(second_try).to equal(first_try) # The alias be() could also be used instead of equal
    end
  end

  context 'eq() vs eql()' do
    it 'shows that eql() is more strict than eq()' do
      expect(3).to eq(3.0)
      expect(3).not_to eql(3.0)
    end
  end

  context 'Square roots' do
    it 'has to include a value greater than 15' do
      squares = 1.upto(4).map { |i| i * i }
      numbers = (10..200).to_a
      expect(squares).to include(a_value > 15)
    end
  end

  context 'Floating-point numbers' do
    it 'checks that 0.1 + 0.2 1= 0.3' do
      expect(0.1 + 0.2).not_to eq(0.3)
    end

    it 'checks within 0.0001' do
      expect(0.1 + 0.2).to be_within(0.0001).of(0.3)
    end
  end

  context 'Town population' do
    it 'has to be within 25 %' do
      town_population = 1250
      expect(town_population).to be_within(25).percent_of(1000)
      expect(town_population).to be_between(750, 1250)
    end
  end

  context 'Predicates' do
    it 'has to be empty' do
      expect([]).to be_empty
    end

    it 'has to be admin' do
      User = Struct.new(:admin?)
      user = User.new(true)
      expect(user).to be_admin
      expect(user).to be_an_admin

      expect(user.admin?).to eq(true) # This reads not as good as the above examples...
    end

    it 'contains a specific key' do
      array_of_hashes = [{ name: "hej", lol: 2 }, { name: "efeef" }, { name: "ejife" }]
      expect(array_of_hashes).to include(have_key(:name) & have_key(:lol))
    end
  end

  context 'Satisfaction' do
    it 'has to satisfy odd condition' do
      expect(1).to satisfy { |number| number.odd? } # block with explicit parameter
      expect(1).to satisfy(&:odd?) # block using shorthand symbol-to-proc
    end

    it 'has to satisfy that an object is even' do
      expect([1, 2, 3, 4, 5]).to include(an_object_satisfying(&:even?))
      expect([2, 4, 6, 60, 10]).to all(satisfying(&:even?))
    end
  end
end