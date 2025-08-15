RSpec.configure do |config|
  config.filter_run_excluding :jruby_only unless RUBY_PLATFORM == 'java'
end

RSpec.configure do |config|
  config.filter_run_when_matching :in_focus
end