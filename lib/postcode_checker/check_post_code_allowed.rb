# frozen_string_literal: true

class PostcodeChecker
  class CheckPostcodeAllowed
    def initialize
      @check_lsoa = CheckLSOA.new
    end

    def call(postcode)
      return true if in_allowed_list?(postcode)
      return true if check_lsoa.call(postcode)

      false
    end

    private

    attr_reader :check_lsoa

    def in_allowed_list?(postcode)
      allowed_postcodes = ENV.fetch('POSTCODES_WHITELISTED').split(',')

      allowed_postcodes.any? do |raw_postcode|
        normalised_postcode = NormalisePostcode.call(raw_postcode)
        normalised_postcode == postcode
      end
    end
  end
end
