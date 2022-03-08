# frozen_string_literal: true

class PostcodeChecker
  class CheckPostcode
    def initialize
      @lsoa_checker = LSOAChecker.new
    end

    def call(request:)
      lsoa_checker.call(request)
    end

    private

    attr_reader :lsoa_checker
  end
end

