RSpec.describe 'Key-value stores' do
  include_examples 'KV Store', HashKVStore
  include_examples 'KV Store', FileKVStore
end