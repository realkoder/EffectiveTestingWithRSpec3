class CookieRecipe
  attr_reader :ingredients

  def initialize
    @ingredients = [:butter, :milk, :flour, :sugar, :eggs, :chocolate_chips]
  end
end

# With explicit descriptions of tests
RSpec.describe CookieRecipe, '#ingredients' do
  it 'should include :butter, :milk and :eggs' do
    expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs)
  end

  it 'should not include :fish_oil' do
    expect(CookieRecipe.new.ingredients).not_to include(:fish_oil)
  end
end

# The code is defining the descriptions
RSpec.describe CookieRecipe, '#ingredients' do
  specify do
    expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs)
  end

  specify do
    expect(CookieRecipe.new.ingredients).not_to include(:fish_oil)
  end
end

RSpec.describe CookieRecipe, '#ingredients' do
  subject { CookieRecipe.new.ingredients }
  it { is_expected.to include(:butter, :milk, :eggs)}
  it { is_expected.not_to include(:fish_oil)}
end