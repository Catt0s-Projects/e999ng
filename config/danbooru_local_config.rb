# frozen_string_literal: true

module Danbooru
  class CustomConfiguration < Configuration
    # Define your custom overloads here

    # override name of the application
    def app_name
      "e999ng"
    end

    # override the default URL for the application
    def domain
      "e999ng.local"
    end

    def source_code_url
      "https://github.com/Catt0s-Projects/e999ng"
    end

    def webp_previews_enabled?
      true
    end

    def disable_throttles?
      true
    end

    def tag_type_change_cutoff
      1_000_000
    end

    def tag_query_limit
      75
    end

    def max_numbered_pages
      100
    end

    def records_per_page
      100
    end

    def deletion_reasons
      [
        "photo",
        "young humanoid explicit",
        "not furry",
        "AI gen",
        "unacceptable compression",
        "corrupted file",
      ]
    end

    def max_image_height
      100_000
    end
    
    def max_image_width
      100_000
    end

    def max_image_resolution
      10_000_000
    end

    def max_video_duration
      3600
    end

    def max_file_size
      100.megabytes
    end

    def max_file_sizes
      {
        "jpg" => 100.megabytes,
        "png" => 100.megabytes,
        "gif" => 20.megabytes,
        "webm" => 100.megabytes,
        "mp4" => 100.megabytes,
      }
    end

    def set_post_limit(_user) # rubocop:disable Naming/AccessorMethodName
      200_000
    end

    def pool_post_limit(_user)
      10_000
    end

    def hourly_upload_limit
      60
    end

        # The method to use for storing image files.
    def storage_manager
      # Store files on the local filesystem.
      # base_dir - where to store files (default: under public/data)
      # base_url - where to serve files from (default: http://#{hostname}/data)
      # hierarchical: false - store files in a single directory
      # hierarchical: true - store files in a hierarchical directory structure, based on the MD5 hash
      StorageManager::Local.new(base_url: Rails.application.routes.url_helpers.root_url, base_dir: Rails.public_path.join("data").to_s, hierarchical: true)
    end

    # def post_page_limit
    #   300
    # end
  end
end