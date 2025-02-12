# frozen_string_literal: true

require 'active_support/core_ext/kernel/reporting'

require 'spec_helper'

module SimpleCov::Formatter
  describe LcovFormatter do
    let(:branch_coverage_enabled) { false }

    before do
      allow($stdout).to receive(:puts) # Silence "Lcov style coverage report generated..." message

      SimpleCov.clear_coverage_criteria
      SimpleCov.enable_coverage :branch if branch_coverage_enabled
      SimpleCov.start { add_filter '/.rvm/' }

      load 'fixtures/app/models/user.rb'
      load 'fixtures/hoge.rb'
    end

    describe '#format' do
      let(:simplecov_result) { SimpleCov.result }

      context 'when generating one report per file' do
        before { LcovFormatter.new.format(simplecov_result) }

        describe File do
          it { expect(File).to exist(File.join(LcovFormatter.config.output_directory, 'spec-fixtures-hoge.rb.lcov')) }

          it do
            expect(File).to exist(
              File.join(LcovFormatter.config.output_directory, 'spec-fixtures-app-models-user.rb.lcov')
            )
          end
        end

        describe 'spec-fixtures-hoge.rb.lcov' do
          let(:output_path) { File.join(LcovFormatter.config.output_directory, 'spec-fixtures-hoge.rb.lcov') }
          let(:fixture) { File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.lcov") }

          it { expect(File.read(output_path)).to eq(fixture) }
        end

        describe 'spec-fixtures-app-models-user.rb.lcov' do
          let(:output_path) do
            File.join(LcovFormatter.config.output_directory, 'spec-fixtures-app-models-user.rb.lcov')
          end
          let(:fixture) { File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-app-models-user.rb.lcov") }

          it { expect(File.read(output_path)).to eq(fixture) }
        end

        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.5')
          describe 'branch coverage enabled' do
            let(:branch_coverage_enabled) { true }

            describe 'spec-fixtures-hoge.rb.branch.lcov' do
              let(:output_path) { File.join(LcovFormatter.config.output_directory, 'spec-fixtures-hoge.rb.lcov') }
              let(:fixture) { File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.branch.lcov") }

              it { expect(File.read(output_path)).to eq(fixture) }
            end

            describe 'spec-fixtures-app-models-user.rb.branch.lcov' do
              let(:output_path) do
                File.join(LcovFormatter.config.output_directory, 'spec-fixtures-app-models-user.rb.lcov')
              end
              let(:fixture) do
                File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-app-models-user.rb.branch.lcov")
              end

              it { expect(File.read(output_path)).to eq(fixture) }
            end
          end
        end
      end

      context 'when generating a single file report' do
        before do
          LcovFormatter.config.report_with_single_file = true
          LcovFormatter.new.format(simplecov_result)
        end

        describe File do
          it { expect(File).to exist(LcovFormatter.config.single_report_path) }
        end

        describe 'single_report_path' do
          let(:output_path) { LcovFormatter.config.single_report_path }
          let(:fixture_of_hoge) { File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-hoge.rb.lcov") }
          let(:fixture_of_user) do
            File.read("#{File.dirname(__FILE__)}/fixtures/lcov/spec-fixtures-app-models-user.rb.lcov")
          end

          it { expect(File.read(output_path)).to match(fixture_of_hoge) }
          it { expect(File.read(output_path)).to match(fixture_of_user) }
        end
      end
    end
  end

  describe '.report_with_single_file=' do
    before do
      allow(LcovFormatter).to receive(:warn)
      allow(LcovFormatter.config).to receive(:report_with_single_file=)
    end

    it 'sets configuration options correctly' do
      LcovFormatter.report_with_single_file = true
      expect(LcovFormatter.config).to have_received(:report_with_single_file=).with(true)
    end

    it 'shows deprecation warning' do
      LcovFormatter.report_with_single_file = true
      expect(LcovFormatter).to have_received(:warn).with(/LcovFormatter\.report_with_single_file=` is deprecated/)
    end
  end
end
