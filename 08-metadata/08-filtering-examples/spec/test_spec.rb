RSpec.describe 'Testing' do
  it 'should just run and parse', :in_focus do
    expect(0).to eq(0)
  end

  context 'when omitting tag in_focus' do
    it 'should not be running' do
      expect(100).to eq(0)
    end
  end
end

