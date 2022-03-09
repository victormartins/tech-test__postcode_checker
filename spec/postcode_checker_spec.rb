# frozen_string_literal: true

POSTCODES_IN_LSOA = [
  'SE1 7QD',
  'SE1 7QA'
].freeze

POSTCODES_WHITELISTED = [
  'SH24 1AA',
  'SH24 1AB'
].freeze

POSTCODES_NOT_ALLOWED = [
  'SN4 0PW',
  'SH24 1AC'
].freeze

POSTCODES_ALLOWED = POSTCODES_IN_LSOA + POSTCODES_WHITELISTED

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
      context "when the postcode not allowed: #{postcode}" do
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
      describe 'with invalid params' do
        context 'when the postcode is missing' do
          let(:params) { {} }

          it 'returns 422' do
            expect(last_response.status).to be(422)
          end

          it 'returns a not allowed postcode response with errors' do
            json_response = JSON.parse(last_response.body)

            expect(json_response).to match(
              'postcode' => '',
              'allowed' => false,
              'errors' => ["Postcode can't be blank"]
            )
          end
        end

        context 'when the postcode is invalid' do
          let(:params) { { postcode: 'XX' } }

          it 'returns 422' do
            expect(last_response.status).to be(422)
          end

          it 'returns a not allowed postcode response with errors' do
            json_response = JSON.parse(last_response.body)

            expect(json_response).to match(
              'postcode' => 'XX',
              'allowed' => false,
              'errors' => ['Postcode invalid format!']
            )
          end
        end

        context 'when unauthorized params are sent' do
          let(:params) { { unkonwn: 'XX' } }

          it 'returns 422' do
            expect(last_response.status).to be(422)
          end

          it 'returns a not allowed postcode response with errors' do
            json_response = JSON.parse(last_response.body)

            expect(json_response).to match(
              'postcode' => '',
              'allowed' => false,
              'errors' => ['Unauthorized Params Sent!']
            )
          end
        end
      end
    end
  end
end
