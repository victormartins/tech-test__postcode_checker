# frozen_string_literal: true

RSpec.describe PostcodeChecker::LookupPostcode do
  let(:postcode) { 'SE1 7QD' }
  let(:normalised_postcode) { PostcodeChecker::NormalisePostcode.call('SE1 7QD') }
  let(:successful_response) { File.read("#{__dir__}/../fixtures/postcodes_io__#{normalised_postcode}.txt") }
  let(:api_url) { "#{ENV.fetch('POSTCODE_IO_LOOKUP_API')}/#{normalised_postcode}" }
  let!(:api_request) do
    stub_request(:get, api_url)
      .to_return(body: successful_response)
  end

  subject(:lookup_postcode) { described_class.new }

  it 'calls the API' do
    lookup_postcode.call(normalised_postcode)

    expect(api_request).to have_been_made
  end

  it 'returns a response object' do
    response = lookup_postcode.call(normalised_postcode)

    expect(response).to be_a(described_class::Response)
    expect(response.status).to eql(200)
    expect(response.postcode).to eql(postcode)
    expect(response.lsoa).to eql('Southwark 034A')
  end
end
