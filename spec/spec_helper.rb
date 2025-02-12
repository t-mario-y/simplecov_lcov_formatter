# frozen_string_literal: true

require 'simplecov'
require 'fileutils'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure { clean_filters }

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'simplecov_lcov_formatter'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before { FileUtils.rm_rf(SimpleCov::Formatter::LcovFormatter.config.output_directory) }
end
