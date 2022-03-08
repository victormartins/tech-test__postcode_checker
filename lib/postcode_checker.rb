# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'logger'
require 'net/http'

class PostcodeChecker < Sinatra::Base
  require_relative 'postcode_checker/check_post_code_allowed'
  require_relative 'postcode_checker/normalise_postcode'
  require_relative 'postcode_checker/lookup_postcode'
  require_relative 'postcode_checker/check_lsoa'

  if ENV['RACK_ENV'] == 'test'
    disable :show_exceptions
    enable :raise_errors
  end

  def self.logger
    @logger ||= Logger.new($stdout)
  end

  post '/check_postcode' do
    PostcodeChecker.logger.info("Sent Params: #{params}")

    # TODO: Validate Request
    # request = CheckPostcodeAllowedRequest.new(params)
    # postcode = request.postcode_normalised
    postcode = NormalisePostcode.call(
      params.fetch(:postcode)
    )

    allowed = CheckPostcodeAllowed.new.call(postcode)

    json(
      allowed: allowed,
      postcode: params.fetch(:postcode)
    )
  end
end
