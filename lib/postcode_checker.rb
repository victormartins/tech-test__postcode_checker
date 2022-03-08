# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'logger'

class PostcodeChecker < Sinatra::Application
  def self.logger
    @logger ||= Logger.new($stdout)
  end

  post '/postcode_lookup' do
    PostcodeChecker.logger.info("Sent Params: #{params}")

    if true #request.valid?
      # allowed =
      json(
        allowed: true,
        postcode: params.fetch(:postcode)
      )
    end

  end
end
