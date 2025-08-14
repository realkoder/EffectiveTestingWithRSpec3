# Description as a string
RSpec.describe 'My awesome gardening API' do
end

# Class
RSpec.describe Perennials::Rhubarb do
end

# Module
RSpec.describe Perennials do
end

# Object
RSpec.describe my_favorite_broccoli do
end

# Combining class/module/object with string
RSpec.describe Garden, 'in winther' do
end

# They all works fine with also including metadata tag
RSpec.describe WeatherStation, 'radar updates', uses_network: true do
end

# It block which takes description and a tag
RSpec.describe Sprinkler do
  it 'waters the garden', uses_serial_bus: true
end

# Grouping related examples together with 'describe'
RSpec.describe 'A kettle of water' do
  describe 'when boiling' do
    it 'can make tea'
    it 'can make coffee'
  end
end

# Doing the same as above but with context which reads awkwardly...
RSpec.describe 'A kettle of water' do
  context 'when boiling' do
    it 'can make tea'
    it 'can make coffee'
  end
end

# USING 'EXAMPLE' INSTEAD OF 'IT'
RSpec.describe PhoneNumberParser do
  it 'in xxx-xxx-xxx  form'
  it 'in (xxx) xxx-xxx-xxx form'
end

# Doesn't make sense to phrase each example with 'it' which is why 'example' can be use instead of
RSpec.describe PhoneNumberParser do
  example 'in xxx-xxx-xxx  form'
  example 'in (xxx) xxx-xxx-xxx form'
end

# USING 'SPECIFY' INSTEAD OF 'IT'
RSpec.describe 'Deprecations' do
  specify 'MyGem.config is deprecated in favor of MyGem.configure'
  specify 'MyGem.run is deprecated in favor of MyGem.start'
end