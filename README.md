# simplecov_lcov_formatter

[![Gem Version](https://badge.fury.io/rb/simplecov_lcov_formatter.svg)](https://badge.fury.io/rb/simplecov_lcov_formatter)
[![Ruby specs](https://github.com/t-mario-y/simplecov_lcov_formatter/actions/workflows/ruby.yml/badge.svg)](https://github.com/t-mario-y/simplecov_lcov_formatter/actions/workflows/ruby.yml)
[![Lint](https://github.com/t-mario-y/simplecov_lcov_formatter/actions/workflows/lint.yml/badge.svg)](https://github.com/t-mario-y/simplecov_lcov_formatter/actions/workflows/lint.yml)

LCOV formatter for SimpleCov. Successor of [simplecov-lcov](https://github.com/fortissimo1997/simplecov-lcov).

## Usage

Output report per file:

```Ruby
require 'simplecov'
require 'simplecov_lcov_formatter'
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start
```

Output report as single file:

```Ruby
require 'simplecov'
require 'simplecov_lcov_formatter'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start
```

Other available configuration options for single file report:

```Ruby
SimpleCov::Formatter::LcovFormatter.config do |c|
  c.output_directory = 'your/path' # default: "coverage/lcov"
  c.lcov_file_name = 'lcov.info' # default: "YOUR_PROJECT_NAME.lcov"
  c.single_report_path = 'your/path/lcov.info'
end
```

## Contributing

TBD
