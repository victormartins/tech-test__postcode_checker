# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra'
require 'sinatra/json'
require 'logger'
require 'net/http'
require 'active_model'

class PostcodeChecker < Sinatra::Base
  require_relative 'postcode_checker/check_postcode_request'
  require_relative 'postcode_checker/check_post_code_allowed'
  require_relative 'postcode_checker/normalise_postcode'
  require_relative 'postcode_checker/lookup_postcode'
  require_relative 'postcode_checker/check_lsoa'

  disable :show_exceptions
  enable :raise_errors

  error ActiveModel::UnknownAttributeError do |e|
    PostcodeChecker.logger.error("Unauthorized params sent! #{e.message}")

    handle_unauthorized_params
  end

  error 404 do |e|
    status 404
    json({})
  end

  def self.logger
    @logger ||= Logger.new($stdout)
  end

  post '/check_postcode' do
    PostcodeChecker.logger.debug("Sent Params: #{params}")

    request = CheckPostcodeRequest.new(params)

    return handle_invalid_request(request) unless request.valid?

    normalised_postcode = NormalisePostcode.call(
      request.postcode
    )

    allowed = CheckPostcodeAllowed.new.call(normalised_postcode)

    json(
      allowed: allowed,
      postcode: request.postcode
    )
  end

  private

  def handle_invalid_request(request)
    status 422

    json(
      allowed: false,
      postcode: request.postcode.to_s,
      errors: request.errors.full_messages
    )
  end

  def handle_unauthorized_params
    status 422

    json(
      allowed: false,
      postcode: '',
      errors: ['Unauthorized Params Sent!']
    )
  end
end
