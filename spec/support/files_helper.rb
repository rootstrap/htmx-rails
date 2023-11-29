# frozen_string_literal: true

module Support
  module FilesHelper
    def generate_application_js(location_folder)
      pathname = File.join([destination_root, location_folder])
      FileUtils.mkdir_p(pathname)
      File.write("#{pathname}/application.js", '')
    end

    def generate_bun_config
      FileUtils.mkdir_p(destination_root)
      File.write("#{destination_root}/bun.config.js", "// Some JS\n")
    end
  end
end
