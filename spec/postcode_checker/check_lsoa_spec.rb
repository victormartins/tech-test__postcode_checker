# frozen_string_literal: true

ALLOWED_LSOA = %w[Southwark Lambeth].freeze

RSpec.describe PostcodeChecker::CheckLSOA do
  let(:postcode) { 'postcode' }

  subject(:check_lsoa) do
    lookup_postcode_double = instance_double(PostcodeChecker::LookupPostcode, call: lsoa_response)
    described_class.new(lookup_postcode: lookup_postcode_double)
  end

  ALLOWED_LSOA.each do |lsoa|
    context "when the postcode is from an allowed LSOA:LSOA #{lsoa}" do
      let(:lsoa_response) { double(lsoa: lsoa) }

      it 'returns true' do
        expect(check_lsoa.call(postcode)).to be(true)
      end
    end
  end

  context 'when the postcode is not from an allowed LSOA' do
    let(:lsoa_response) { double(lsoa: 'NotAllowed') }

    it 'returns false' do
      expect(check_lsoa.call(postcode)).to be(false)
    end
  end
end
