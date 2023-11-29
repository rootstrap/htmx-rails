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
    before do
      hide_const('Webpacker')
      hide_const('Importmap')
      stub_const('Sprockets', Module.new)
    end

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
      hide_const('Sprockets')
      hide_const('Importmap')

      expect_any_instance_of(Htmx::Generators::InstallGenerator)
        .to receive(:webpack_source_path)
        .at_least(1).time
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

  context 'with Importmap' do
    before do
      hide_const('Webpacker')
      hide_const('Sprockets')
      stub_const('Importmap', Module.new)
    end

    context 'when `application.js` exists' do
      before do
        generate_application_js('/app/javascript')
      end

      it 'updates file with htmx import' do
        run_generator
        assert_file(
          'app/javascript/application.js',
          "\n#{Htmx::Generators::InstallGenerator::IMPORTMAP_SETUP}"
        )
      end
    end

    context 'when `application.js` does not exists' do
      it 'creates `application.js` file with htmx import' do
        run_generator
        assert_file(
          'app/javascript/application.js',
          Htmx::Generators::InstallGenerator::IMPORTMAP_SETUP
        )
      end
    end
  end

  context 'with bun configured' do
    before do
      generate_bun_config
    end

    context 'when `application.js` exists' do
      before do
        generate_application_js('/app/javascript')
      end

      it 'updates file with htmx import' do
        run_generator
        assert_file(
          'app/javascript/application.js',
          "\n#{Htmx::Generators::InstallGenerator::IMPORTMAP_SETUP}"
        )
      end
    end

    context 'when `application.js` does not exists' do
      it 'creates `application.js` file with htmx require' do
        run_generator
        assert_file(
          'app/javascript/application.js',
          Htmx::Generators::InstallGenerator::IMPORTMAP_SETUP
        )
      end
    end
  end

  context 'with no asset pipeline' do
    before do
      hide_const('Webpacker')
      hide_const('Sprockets')
      hide_const('Importmap')
    end

    it 'raise an error' do
      expect { run_generator }.to raise_error('No known asset pipeline detected')
    end
  end
end
