RSpec.describe 'Doubles' do
  it ''
  allow(double).to receive(:a_message).and_return(a_return_value)
  allow(double).to receive(:a_message).and_raise(AnException)
  allow(double).to receive(:a_message).and_yield(a_value_to_a_block)
  allow(double).to receive(:a_message).and_throw(_a: symbol, optional_value)
  allow(double).to receive(:a_message) { |arg| do_something_with(arg) }

  # These last two are just for partial doubles:
  allow(double).to receive(:a_message).and_call_original
  allow(double).to receive(:a_message).and_wrap_original { |original| }
end