# frozen_string_literal: true

module Htmx
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      WEBPACKER_SETUP = "require('htmx.org')\n"
      SPROCKETS_SETUP = "//= require htmx\n"
      IMPORTMAP_SETUP = "import \"htmx.org\"\n"
      BUN_SETUP       = IMPORTMAP_SETUP

      desc 'Prep application.js to include HTMX installation for Webpacker, Sprockets or Importmap'

      # Setup HTMX
      def setup
        return setup_bun if bun?
        return setup_importmap if importmap?
        return setup_webpacker if webpacker?
        return setup_sprockets if sprockets?

        raise 'No known asset pipeline detected.'
      end

      private

      def bun?
        Pathname.new(destination_root).join('bun.config.js').exist?
      end

      def webpacker?
        !!defined?(Webpacker)
      end

      def sprockets?
        !!defined?(Sprockets)
      end

      def importmap?
        !!defined?(Importmap)
      end

      def manifest(javascript_dir)
        Pathname.new(destination_root).join(javascript_dir, 'application.js')
      end

      def add_to_manifest(manifest, text)
        if manifest.exist?
          append_file manifest, "\n#{text}"
        else
          create_file manifest, text
        end
      end

      def setup_bun
        run "bun add htmx.org@#{Htmx::Rails::HTMX_VERSION}"

        add_to_manifest(manifest('app/javascript'), BUN_SETUP)
      end

      def setup_importmap
        run "bin/importmap pin htmx.org@#{Htmx::Rails::HTMX_VERSION}"

        add_to_manifest(manifest('app/javascript'), IMPORTMAP_SETUP)
      end

      def setup_sprockets
        add_to_manifest(manifest('app/assets/javascripts'), SPROCKETS_SETUP)
      end

      def setup_webpacker
        run "yarn add htmx.org@#{Htmx::Rails::HTMX_VERSION}"

        add_to_manifest(manifest(webpack_source_path), WEBPACKER_SETUP)
      end

      def webpack_source_path
        (Webpacker.try(:config).try(:source_entry_path) ||
          Webpacker::Configuration.source_path.join(
            Webpacker::Configuration.entry_path
          )
        ).relative_path_from(::Rails.root).to_s
      end
    end
  end
end
