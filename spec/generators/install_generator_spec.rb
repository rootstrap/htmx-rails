# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HtmxRails::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../tmp', __dir__)

  context 'with Sprockets' do
    context 'when application.js exists' do
      before(:each) do
        prepare_destination
        FileUtils.mkdir_p("#{destination_root}/app/assets/javascripts/")
        File.write("#{destination_root}/app/assets/javascripts/application.js", '')
        run_generator
      end

      it 'creates application.js file' do
        assert_file 'app/assets/javascripts/application.js', '//= require htmx'
      end
    end

    context 'when application.js does not exists' do
      before(:each) do
        prepare_destination
        run_generator
      end

      it 'updates application.js file' do
        assert_file 'app/assets/javascripts/application.js', '//= require htmx'
      end
    end
  end

  # context 'with Webpacker' do
  #   context 'with no arguments' do
  #     before(:each) do
  #       allow(::Rails).to receive(:version) { '3.1.0' }
  #       prepare_destination
  #       run_generator
  #     end

  #     it 'does not copy cocoon.js' do
  #       assert_no_file 'public/javascripts/cocoon.js'
  #     end
  #   end
  # end

end
