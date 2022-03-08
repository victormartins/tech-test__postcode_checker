# frozen_string_literal: true

RSpec.describe PostcodeChecker::LookupPostcode do
  let(:postcode) { 'SE1 7QD' }
  let(:normalised_postcode) { PostcodeChecker::NormalisePostcode.call('SE1 7QD') }
  let(:api_url) { "#{ENV.fetch('POSTCODE_IO_LOOKUP_API')}/#{normalised_postcode}" }
  let(:http_response) { File.read("#{__dir__}/../fixtures/postcodes_io__#{normalised_postcode}.txt") }
  let!(:api_request) do
    stub_request(:get, api_url)
      .to_return(body: http_response)
  end

  subject(:lookup_postcode) { described_class.new }

  describe 'Happy Path' do
    it 'calls the API' do
      lookup_postcode.call(normalised_postcode)

      expect(api_request).to have_been_made
    end

    it 'returns a response object' do
      response = lookup_postcode.call(normalised_postcode)

      expect(response).to be_a(described_class::Response)
      expect(response.successful?).to eql(true)
      expect(response.postcode).to eql(postcode)
      expect(response.lsoa).to eql('Southwark 034A')
    end
  end

  describe 'Errors Path' do
    context 'when we get an exception' do
      let(:api_request) do
        stub_request(:get, api_url)
          .to_raise(StandardError)
      end

      it 'returns a non successful response' do
        response = lookup_postcode.call(normalised_postcode)

        expect(response).to be_a(described_class::Response)
        expect(response.successful?).to eql(false)
        expect(response.postcode).to be_nil
        expect(response.lsoa).to be_nil
      end
    end
  end
end
