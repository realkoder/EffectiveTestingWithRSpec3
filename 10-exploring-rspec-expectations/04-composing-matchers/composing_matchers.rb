RSpec.describe 'Composed Matchers' do
  context 'Presidents' do
    let(:presidents) { [
      { name: 'George Washington', birth_year: 1732 },
      { name: 'John Adams', birth_year: 1735 },
      { name: 'Thomas Jefferson', birth_year: 1743 }
    ] }
    it 'should start with George and John' do
      expect(presidents).to start_with(
                              { name: 'George Washington', birth_year: 1732 },
                              { name: 'John Adams', birth_year: 1735 },
                            )
    end
  end

  context 'Stoplight Colors' do
    it 'is only allowed to be green / red / yellow' do
      stoplight_color = %w[ green yellow red ].sample
      # expect(stoplight_color).to eq('green').or eq('yellow').or eq('red')
      expect(stoplight_color).to eq('green') | eq('yellow') | eq('red')
    end
  end

  context 'Strings' do
    it 'has String starting with letter `A` and ending with `M` + String starting with `N` and ending with `Z`' do
      letter_ranges = ['N to Z', 'A to M']
      expect(letter_ranges).to contain_exactly(
                                 a_string_starting_with('A') & ending_with('M'),
                                 a_string_starting_with('N') & ending_with('Z'),
                               )
    end
  end
end