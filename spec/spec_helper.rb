# frozen_string_literal: true

require "simplecov"

ENV["BRANCH_COVERAGE"].to_s.length > 0 ? SimpleCov.enable_coverage(:branch) : nil # [2020-10-18]: this is not compatible with Undercover yet.
# SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  track_files "{app,lib}/**/*.rb"
  add_filter(/^\/spec\//) # For RSpec
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
