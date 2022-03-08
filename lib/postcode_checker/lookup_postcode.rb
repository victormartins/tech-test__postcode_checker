# frozen_string_literal: true

class PostcodeChecker
  # This class hides the dependencie of where
  # we get the Postcode Information.
  # It also estables a response object isolate
  # the consumer to any external payload dependencies.
  class LookupPostcode
    Response = Struct.new(
      :status,
      :postcode,
      :lsoa
    )

    def call(postcode)
      api = ENV.fetch('POSTCODE_IO_LOOKUP_API')
      uri = URI("#{api}/#{postcode}")

      PostcodeChecker.logger.debug("#{self.class.name} - Calling: #{uri}")

      http_request = Net::HTTP.get_response(uri)
      raw_response = http_request.body

      json_response = JSON.parse(raw_response)

      Response.new(
        json_response['status'],
        json_response.dig('result', 'postcode'),
        json_response.dig('result', 'lsoa')
      )
    end
  end
end
