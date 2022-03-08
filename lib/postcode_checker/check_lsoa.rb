# frozen_string_literal: true

class PostcodeChecker
  # This class isolates the rules of which postcodes are allowed based on LSOA
  class CheckLSOA
    def initialize(lookup_postcode: LookupPostcode.new)
      @lookup_postcode = lookup_postcode
    end

    def call(postcode)
      postcode_data = lookup_postcode.call(postcode)
      lsoa = postcode_data.lsoa

      allowed_lsoa.any? do |allowed|
        lsoa.match(/^#{allowed}/)
      end
    end

    private

    attr_reader :lookup_postcode

    def allowed_lsoa
      ENV.fetch('POSTCODE_ALLOWED_LSOA').split(',')
    end
  end
end
