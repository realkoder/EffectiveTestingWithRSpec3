RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
end

class Coffee
  def ingredients
    @ingredients ||= []
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def price
    1.00
  end
end

RSpec.describe 'A cup of coffee' do
  let(:coffee) { Coffee.new }

  it 'costs $1' do
    expect(coffee.price).to eq(1.00)
  end

  it 'is light in color' do
    pending 'Color not implemented yet'
    expect(coffee.color).to be(:light)
  end

  it 'is cooler than 200 degrees Fahrenheit' do
    pending 'Temperature not implemented yet'
    expect(coffee.temperature).to be < 200.0
  end

  context 'with milk' do
    before { coffee.add :milk }

    it 'costs $1.25' do
      expect(coffee.price).to eq(1.25)
    end
  end
end