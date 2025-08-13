# frozen_string_literal: true

describe 'An ideal sandwich' do
  it 'is delicious' do
    sandwich = Sandwich.new('delicious', [])

    taste = sandwich.taste
    
    # The below line is a more classic way of assertion - rspec makes a more readable approach
    assert_equal('delicious', taste, 'Sandwich is not delicious')
  end
end
