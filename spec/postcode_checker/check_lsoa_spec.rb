# frozen_string_literal: true

ALLOWED_LSOA = %w[Southwark Lambeth].freeze

RSpec.describe PostcodeChecker::CheckLSOA do
  let(:postcode) { 'postcode' }
  let(:success) { true }

  subject(:check_lsoa) do
    lookup_postcode_double = instance_double(PostcodeChecker::LookupPostcode, call: lsoa_response)
    described_class.new(lookup_postcode: lookup_postcode_double)
  end

  ALLOWED_LSOA.each do |lsoa|
    context "when the postcode is from an allowed LSOA:LSOA #{lsoa}" do
      let(:lsoa_response) do
        instance_double(
          PostcodeChecker::LookupPostcode::Response,
          lsoa: lsoa,
          successful?: success
        )
      end

      it 'returns true' do
        expect(check_lsoa.call(postcode)).to be(true)
      end
    end
  end

  context 'when the postcode is not from an allowed LSOA' do
    let(:lsoa_response) do
      instance_double(
        PostcodeChecker::LookupPostcode::Response,
        lsoa: 'NotAllowed',
        successful?: success
      )
    end

    it 'returns false' do
      expect(check_lsoa.call(postcode)).to be(false)
    end
  end

  context 'when the postcode lookup failed' do
    let(:lsoa_response) do
      instance_double(PostcodeChecker::LookupPostcode::Response, successful?: false)
    end

    it 'returns false' do
      expect(check_lsoa.call(postcode)).to be(false)
    end
  end
end
