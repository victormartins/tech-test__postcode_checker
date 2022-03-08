# frozen_string_literal: true

require 'webmock/rspec'
require 'pry-byebug'
require 'rack/test'
require 'pry'

# TODO: Improve configurations
ENV['POSTCODES_WHITELISTED'] = 'SH24 1AA,SH24 1AB'
ENV['POSTCODE_ALLOWED_LSOA'] = 'Southwark,Lambeth'
ENV['POSTCODE_IO_LOOKUP_API'] = 'http://postcodes.io/postcodes'
ENV['RACK_ENV'] = 'test'

require 'postcode_checker'

PostcodeChecker.logger.level = :error

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand config.seed
end
