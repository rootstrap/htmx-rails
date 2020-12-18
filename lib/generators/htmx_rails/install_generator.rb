# frozen_string_literal: true

module HtmxRails
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      WEBPACKER_SETUP = "require('htmx.org')\n"
      SPROCKETS_SETUP = "//= require htmx\n"

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

      def manifest(javascript_dir)
        Pathname.new(destination_root).join(javascript_dir, 'application.js')
      end

      def setup_sprockets
        manifest = manifest('app/assets/javascripts')

        if manifest.exist?
          append_file manifest, "\n#{SPROCKETS_SETUP}"
        else
          create_file manifest, SPROCKETS_SETUP
        end
      end

      def setup_webpacker
        `yarn add htmx.org`

        manifest = manifest(webpack_source_path)

        if manifest.exist?
          append_file(manifest, "\n#{WEBPACKER_SETUP}")
        else
          create_file(manifest, WEBPACKER_SETUP)
        end
      end

      def webpack_source_path
        if Webpacker.respond_to?(:config)
          # Webpacker >3
          Webpacker.config.source_entry_path
        else
          # Webpacker <3
          Webpacker::Configuration.source_path.join(Webpacker::Configuration.entry_path)
        end.relative_path_from(::Rails.root).to_s
      end
    end
  end
end
