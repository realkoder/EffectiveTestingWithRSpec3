# Parse metadata about the runnning example to the it block
RSpec.describe Hash do
  it 'is used by RSpec for metadata' do |example|
    pp example.metadata
  end
end

# Passing a key whose value is true, as in fast: true
RSpec.describe Hash do
  it 'is used by RSpec for metadata', fast: true do |example|
    pp example.metadata
  end
end

# Passing a key whose value is true but omitting the explicit true
RSpec.describe Hash do
  it 'is used by RSpec for metadata', :fast do |example|
    pp example.metadata
  end
end

# Passing multiple keys
RSpec.describe Hash do
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    pp example.metadata
  end
end

# Contained examples and nested groups inherits the metadata -> this should log :outer_group=>true twice
RSpec.describe Hash, :outer_group do
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    pp example.metadata
  end

  context 'on a nested group' do
    it 'is also inherited' do |example|
      pp example.metadata
    end
  end
end