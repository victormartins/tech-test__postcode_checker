# frozen_string_literal: true

POSTCODES_IN_LSOA = [
  'SE1 7QD',
  'SE1 7QA'
].freeze

POSTCODES_INCLUSIONS = [
  'SH24 1AA',
  'SH24 1AB'
].freeze

POSTCODES_ALLOWED = POSTCODES_IN_LSOA + POSTCODES_INCLUSIONS

POSTCODES_NOT_ALLOWED = [
  'SN4 0PW'
].freeze

RSpec.describe PostcodeChecker do
  include Rack::Test::Methods

  def app
    PostcodeChecker.new
  end

  subject(:http_request) { post('/postcode_lookup', params) }

  describe 'POST /postcode' do
    before { http_request }

    POSTCODES_ALLOWED.each do |postcode|
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

    POSTCODES_NOT_ALLOWED.each do |postcode|
      context "when the postcode is not allowed #{postcode}" do
        let(:params) { { postcode: postcode } }

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
    end

    describe 'Error Paths' do
      context 'with invalid params' do
        it 'returns 422'
        it 'returns an error message'
      end
    end
  end
end
