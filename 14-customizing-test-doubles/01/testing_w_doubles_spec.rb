require_relative 'api/app'

RSpec.describe API::App do

  it 'works' do
    my_double = double("MyDouble")
    allow(my_double).to receive(:call).and_return(200)
    expect(my_double.call).to eq(200)
  end

  it 'will use service' do
    service = double('Service')
    allow(service).to receive(:call).and_return('hey YO')
    app = API::App.new(service)
    expect(app.test_me).to eq("hey YO")
  end
end