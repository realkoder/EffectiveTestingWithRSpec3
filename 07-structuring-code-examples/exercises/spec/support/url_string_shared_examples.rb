RSpec.shared_examples 'a URI parsing lib' do |url|

  it 'parses the host' do
    expect(url.parse('http://foo.com/').host).to eq 'foo.com'
  end

  it 'parses the scheme' do
    expect(url.parse('https://a.com/').scheme).to eq 'https'
  end

  it 'parses the path' do
    expect(url.parse('http://a.com/foo').path).to eq '/foo'
  end

  it 'parses the port' do
    expect(url.parse('http://example.com:9876').port).to eq 9876
  end
end