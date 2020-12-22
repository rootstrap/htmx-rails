# frozen_string_literal: true

module Support
  module FilesHelper
    def generate_application_js(location_folder)
      pathname = File.join([destination_root, location_folder])
      FileUtils.mkdir_p(pathname)
      File.write("#{pathname}/application.js", '')
    end
  end
end
