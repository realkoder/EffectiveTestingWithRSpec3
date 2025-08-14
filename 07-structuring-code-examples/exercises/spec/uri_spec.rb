require 'uri'
require_relative 'support/url_string_shared_examples'

RSpec.describe URI do
  it_behaves_like 'a URI parsing lib', URI

  it 'defaults the port for an http URI to 80' do
    expect(URI.parse('http://example.com/').port).to eq 80
  end

  it 'defaults the port for an https URI to 443' do
    expect(URI.parse('https://example.com/').port).to eq 443
  end
end