# frozen_string_literal: true

class PostcodeChecker
  class CheckPostcodeAllowed
    def initialize
      @check_lsoa = CheckLSOA.new
    end

    def call(postcode)
      return true if check_lsoa.call(postcode)
      false
    end

    private

    attr_reader :check_lsoa
  end
end

