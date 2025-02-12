# frozen_string_literal: true

require_relative 'spec_helper'

describe SimpleCovLcovFormatter::Configuration do
  subject(:configuration) { described_class.new }

  describe '#output_directory' do
    context 'when directory is not customized' do
      it 'returns default directory path' do
        expect(configuration.output_directory).to eq File.join(SimpleCov.coverage_path, 'lcov')
      end
    end

    context 'when directory is customized' do
      let(:custom_directory_path) { 'some/custom/path' }

      before { configuration.output_directory = custom_directory_path }

      it 'returns customized directory path' do
        expect(configuration.output_directory).to eq custom_directory_path
      end
    end

    context 'when single_report_path is customized' do
      before { configuration.single_report_path = 'some/custom/path/lcov.info' }

      it 'sets correct path' do
        expect(configuration.output_directory).to eq 'some/custom/path'
      end
    end
  end

  describe '#report_with_single_file?' do
    context 'when no customisations are made' do
      it { is_expected.not_to be_report_with_single_file }
    end

    context 'when report_with_single_file set to true' do
      before { configuration.report_with_single_file = true }

      it { is_expected.to be_report_with_single_file }
    end
  end

  describe '#single_report_path' do
    let(:default_single_report_dir) { File.join(SimpleCov.coverage_path, 'lcov') }
    let(:default_file_name) { 'simplecov_lcov_formatter.lcov' }

    context 'when no path customisations where made' do
      it 'returns default path' do
        default_path = File.join(default_single_report_dir, default_file_name)
        expect(configuration.single_report_path).to eq default_path
      end
    end

    context 'when file name is customised' do
      let(:custom_file_name) { 'my-custom-file.info' }

      before { configuration.lcov_file_name = custom_file_name }

      it 'returns path with custom file name' do
        path_with_custom_file_name = File.join(default_single_report_dir, custom_file_name)
        expect(configuration.single_report_path).to eq path_with_custom_file_name
      end
    end

    context 'when output directory is customised' do
      let(:custom_file_directory) { 'path/to/my/custom/dir' }

      before { configuration.output_directory = custom_file_directory }

      it 'returns path with custom file name' do
        customized_path = File.join(custom_file_directory, default_file_name)
        expect(configuration.single_report_path).to eq customized_path
      end
    end

    context 'when single_report_path is customised' do
      let(:custom_path) { 'my/path/with/file.lcov' }

      before { configuration.single_report_path = custom_path }

      it 'returns customised path' do
        expect(configuration.single_report_path).to eq custom_path
      end
    end
  end
end
