# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Htmx::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../tmp', __dir__)

  let!(:generate_files) {}

  before(:each) do
    prepare_destination
    generate_files
  end

  after(:all) { FileUtils.rm_rf destination_root }

  def generate_application_js(location_folder)
    pathname = File.join([destination_root, location_folder])
    FileUtils.mkdir_p(pathname)
    File.write("#{pathname}/application.js", '')
  end

  context 'with Sprockets' do
    before(:each) do
      run_generator
    end

    context 'when `application.js` exists' do
      let!(:generate_files) do
        generate_application_js('/app/assets/javascripts')
      end

      it 'creates `application.js` file with htmx require' do
        assert_file(
          'app/assets/javascripts/application.js',
          Htmx::Generators::InstallGenerator::SPROCKETS_SETUP
        )
      end
    end

    context 'when `application.js` does not exists' do
      it 'updates file with htmx require' do
        assert_file(
          'app/assets/javascripts/application.js',
          Htmx::Generators::InstallGenerator::SPROCKETS_SETUP
        )
      end
    end
  end

  context 'with Webpacker' do
    before(:each) do
      stub_const('Webpacker', Module.new)

      Htmx::Generators::InstallGenerator
        .any_instance
        .stub(:webpack_source_path)
        .and_return(File.join("#{destination_root}/app/javascript/packs"))

      run_generator
    end

    context 'when `application.js` exists' do
      it 'creates `application.js` file with htmx require' do
        assert_file(
          'app/javascript/packs/application.js',
          Htmx::Generators::InstallGenerator::WEBPACKER_SETUP
        )
      end
    end

    context 'when `application.js` does not exists' do
      let!(:generate_files) do
        generate_application_js('/app/javascript')
      end

      it 'updates `application.js` file with htmx require' do
        assert_file(
          'app/javascript/packs/application.js',
          Htmx::Generators::InstallGenerator::WEBPACKER_SETUP
        )
      end
    end
  end
end
