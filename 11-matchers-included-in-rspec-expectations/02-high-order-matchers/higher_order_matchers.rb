RSpec.describe 'Higher Order Matchers' do
  context 'Strings' do
    it 'includes substring' do
      expect('a string').to include('str')

      # We can also use include with an array since string is almost just array of chars
      expect([1, 3]).to include(3)
    end
  end

  context 'Hashes' do
    it 'includes a given key' do
      test_case = { name: 'Harry Potter', age: 19 }
      expect(test_case).to include(:name)
      expect(test_case).to include(age: 19)
    end
  end

  context 'Objects' do
    User = Struct.new(:name)
    it 'contains specific attributes' do
      test_case = User.new('Harry Potter')
      expect(test_case).to have_attributes(name: 'Harry Potter')
    end
    context 'within an array' do
      it 'contains an object with a given attribute' do
        test_case = User.new('Harry Potter')
        expect([test_case]).to include(an_object_having_attributes(name: 'Harry Potter'))
      end
    end
  end

  context 'Arrays' do
    it 'includes expecteds' do
      expecteds = [2, 3]
      expect([1, 2, 3]).to include(*expecteds)
    end
  end

  context 'Numbers' do
    it 'has to all be even numbers' do
      numbers = [2, 10, 20, 30, 180]
      RSpec::Matchers::define_negated_matcher :be_non_empty, :be_empty
      expect(numbers).to be_non_empty.and all be_even
    end
  end
end