Gem::Specification.new do |s|
  s.name = 'simplecov_lcov_formatter'
  s.version = '0.8.0'

  s.require_paths = ['lib']
  s.authors = ['t-mario-y']
  s.date = '2024-07-19'
  s.description = 'LCOV formatter for SimpleCov. Successor of simplecov-lcov.'
  s.summary = 'LCOV formatter for SimpleCov. Successor of simplecov-lcov.'
  s.files = Dir.glob('lib/**/*.rb') + %w[LICENSE README.md VERSION]
  s.homepage = 'https://github.com/t-mario-y/simplecov_lcov_formatter'
  s.licenses = 'MIT'

  s.add_development_dependency('activesupport', '> 0')
  s.add_development_dependency('rspec', '> 0')

  s.add_dependency('simplecov', '>= 0.18')
end
