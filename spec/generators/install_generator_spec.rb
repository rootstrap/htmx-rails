# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Htmx::Generators::InstallGenerator, type: :generator do
  include Support::FilesHelper

  destination File.expand_path('../tmp', __dir__)

  before do
    prepare_destination
  end

  after(:all) { FileUtils.rm_rf destination_root }

  context 'with Sprockets' do
    context 'when `application.js` exists' do
      before do
        generate_application_js('/app/assets/javascripts')
      end

      it 'updates file with htmx require' do
        run_generator
        assert_file(
          'app/assets/javascripts/application.js',
          "\n#{Htmx::Generators::InstallGenerator::SPROCKETS_SETUP}"
        )
      end
    end

    context 'when `application.js` does not exists' do
      it 'creates `application.js` file with htmx require' do
        run_generator
        assert_file(
          'app/assets/javascripts/application.js',
          Htmx::Generators::InstallGenerator::SPROCKETS_SETUP
        )
      end
    end
  end

  context 'with Webpacker' do
    before do
      stub_const('Webpacker', Module.new)

      Htmx::Generators::InstallGenerator
        .any_instance
        .stub(:webpack_source_path)
        .and_return(File.join("#{destination_root}/app/javascript/packs"))
    end

    context 'when `application.js` exists' do
      before do
        generate_application_js('/app/javascript')
      end

      it 'updates `application.js` file with htmx require' do
        run_generator
        assert_file(
          'app/javascript/packs/application.js',
          Htmx::Generators::InstallGenerator::WEBPACKER_SETUP
        )
      end
    end

    context 'when `application.js` does not exists' do
      it 'creates `application.js` file with htmx require' do
        run_generator
        assert_file(
          'app/javascript/packs/application.js',
          Htmx::Generators::InstallGenerator::WEBPACKER_SETUP
        )
      end
    end
  end
end
