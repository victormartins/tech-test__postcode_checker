# frozen_string_literal: true

POSTCODES_IN_LSOA = [
  'SE1 7QD',
  'SE1 7QA'
].freeze

RSpec.describe PostcodeChecker do
  include Rack::Test::Methods

  def app
    PostcodeChecker.new
  end

  subject(:http_request) { post('/check_postcode', params) }

  before do
    WebMock.disable!
  end

  describe 'POST /check_postcode' do
    before { http_request }

    POSTCODES_IN_LSOA.each do |postcode|
      context "when the postcode is allowed: #{postcode}" do
        let(:params) { { postcode: postcode } }

        it 'returns 200' do
          expect(last_response.status).to be(200)
        end

        it 'returns a allowed postcode response' do
          json_response = JSON.parse(last_response.body)

          expect(json_response).to match(
            'postcode' => params.fetch(:postcode),
            'allowed' => true
          )
        end
      end
    end

    context 'when the postcode is not allowed' do
      let(:params) { { postcode: 'SN4 0PW' } }

      it 'returns 200' do
        expect(last_response.status).to be(200)
      end

      it 'returns a not allowed postcode response' do
        json_response = JSON.parse(last_response.body)

        expect(json_response).to match(
          'postcode' => params.fetch(:postcode),
          'allowed' => false
        )
      end
    end

    describe 'Error Paths' do
      context 'with invalid params' do
        it 'returns 422'
        it 'returns an error message'
      end
    end
  end
end
