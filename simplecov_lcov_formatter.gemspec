# frozen_string_literal: true

require_relative 'lib/simplecov_lcov_formatter/version'

Gem::Specification.new do |s|
  s.name = 'simplecov_lcov_formatter'
  s.version = SimpleCovLcovFormatter::VERSION

  s.require_paths = ['lib']
  s.authors = ['t-mario-y']
  s.description = 'LCOV formatter for SimpleCov. Successor of simplecov-lcov.'
  s.summary = 'LCOV formatter for SimpleCov. Successor of simplecov-lcov.'
  s.files = Dir.glob('lib/**/*.rb') + %w[LICENSE README.md]
  s.homepage = 'https://github.com/t-mario-y/simplecov_lcov_formatter'
  s.licenses = 'MIT'

  s.required_ruby_version = '>= 2.5'

  s.metadata['rubygems_mfa_required'] = 'true'

  s.add_dependency('simplecov', '>= 0.18')
end
