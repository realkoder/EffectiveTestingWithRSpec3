RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    # Sets the flag unconditionally
    # doesn't allow examples to opt out
    # meta[:aggregate_failures] = true

    # This allows opting out
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
end

RSpec.describe 'Billing', aggregate_failures: false do

  context 'false failures' do
    it 'fails' do
      expect(1).to eq(0)
      expect(100).to eq(10)
    end
  end
end