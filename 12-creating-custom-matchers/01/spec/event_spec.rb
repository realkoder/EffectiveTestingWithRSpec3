RSpec::Matchers.define :have_no_tickets_sold do
  match do |art_show|
    art_show.tickets_sold.count.zero?
  end

  failure_message do |art_show|
    "expected ArtShow to have no tickets sold, but found #{art_show.tickets_sold.count}"
  end
end

RSpec::Matchers.define :be_sold_out do
  match do |art_show|
    art_show.tickets_sold.count == art_show.capacity
  end

  failure_message do |art_show|
    "expected ArtShow to be sold out, but #{art_show.tickets_sold.count}/#{art_show.capacity} tickets sold"
  end
end

RSpec.describe 'Custom Matchers' do
  ArtShow = Struct.new(:tickets_sold, :capacity)
  let(:art_show) { ArtShow.new([]) }
  let(:u2_concert) { ArtShow.new((1..1000).to_a, 1000) }

  it 'reads weird since deeper nested attributes accessed for the example' do
    expect(art_show.tickets_sold.count).to eq(0)
    expect(u2_concert.tickets_sold.count).to eq(u2_concert.capacity)
  end

  it 'reads much more clearly using custom matchers' do
    expect(art_show).to have_no_tickets_sold
    expect(u2_concert).to be_sold_out
  end
end