RSpec.describe 'Block Matchers' do
  context 'Error raise' do
    it 'raises an error' do
      expect { 'hello'.world }.to raise_error(an_object_having_attributes(name: :world))

      expect { 'hello'.world }.to raise_error(NoMethodError) do |ex|
        expect(ex.name).to eq(:world)
      end
    end
  end
end