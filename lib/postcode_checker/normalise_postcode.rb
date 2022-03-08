# frozen_string_literal: true

class PostcodeChecker
  # This class isolates the logic of how we normalise a postcode
  # so that it is consistent accross the application
  class NormalisePostcode
    def self.call(postcode)
      postcode
        .downcase
        .gsub(' ', '')
    end
  end
end
