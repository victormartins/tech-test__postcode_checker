# frozen_string_literal: true

class PostcodeChecker
  # This class is responsible to ensure that request data is validated
  # and produce human readable error messages.
  class CheckPostcodeRequest
    include ActiveModel::Model

    attr_accessor :postcode

    validates :postcode, presence: true

    validates :postcode, format: {
      # https://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom#Validationhttps://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom#Validation
      with: /\A[A-Z]{1,2}[0-9][A-Z0-9]? ?[0-9][A-Z]{2}\z/,
      message: 'invalid format!',
      allow_blank: true
    }
  end
end
