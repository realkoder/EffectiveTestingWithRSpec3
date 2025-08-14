require 'addressable'
require_relative 'support/url_string_shared_examples'

RSpec.describe Addressable do
  it_behaves_like 'a URI parsing lib', Addressable::URI
end