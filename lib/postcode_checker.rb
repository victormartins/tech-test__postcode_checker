# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'logger'

class PostcodeChecker < Sinatra::Base
  if ENV['RACK_ENV'] == 'test'
    disable :show_exceptions
    enable :raise_errors
  end

  def self.logger
    @logger ||= Logger.new($stdout)
  end

  post '/postcode_lookup' do
    PostcodeChecker.logger.info("Sent Params: #{params}")

    allowed = CheckPostcode.new.call(request: request)

    json(
      allowed: allowed,
      postcode: params.fetch(:postcode)
    )
  end
end
