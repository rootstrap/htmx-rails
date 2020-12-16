# frozen_string_literal: true

module HtmxRails
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      WEBPACKER_SETUP = 'require(\'htmx.org\')'
      SPROCKETS_SETUP = '//= require htmx'

      desc 'Prep application.js to include HTMX installation for Webpacker or Sprockets'

      # Setup HTMX
      def setup
        if webpacker?
          setup_webpacker
        else
          setup_sprockets
        end
      end

      private

      def webpacker?
        !!defined?(Webpacker)
      end

      def javascript_dir
        if webpacker?
          webpack_source_path
            .relative_path_from(::Rails.root)
            .to_s
        else
          'app/assets/javascripts'
        end
      end

      def manifest
        Pathname.new(destination_root).join(javascript_dir, 'application.js')
      end

      def setup_sprockets
        if manifest.exist?
          append_file manifest, SPROCKETS_SETUP
        else
          create_file manifest, SPROCKETS_SETUP
        end
      end

      def setup_webpacker
        `yarn add htmx.org`
        if manifest.exist?
          append_file(manifest, WEBPACKER_SETUP)
        else
          create_file(manifest, WEBPACKER_SETUP)
        end
      end

      def webpack_source_path
        if Webpacker.respond_to?(:config)
          Webpacker.config.source_entry_path # Webpacker >3
        else
          Webpacker::Configuration.source_path.join(Webpacker::Configuration.entry_path) # Webpacker <3
        end
      end
    end
  end
end
