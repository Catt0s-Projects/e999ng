# frozen_string_literal: true

class RemoteIqdbMatch < ApplicationRecord
  belongs_to :post

  enum source: { e621: 0, other_iqdb: 1 }
  enum status: { active: 0, deleted: 1, other: 2 }
  enum remote_file_type: { jpg: 0, png: 1, gif: 2, webp: 3, mp4: 4, webm: 5, jxl: 6, avif: 7 }

  validates :remote_file_size, presence: true
  validates :remote_width, presence: true
  validates :remote_height, presence: true
  validates :remote_compression
  validates :simularity, presence: true
  validates :remote_id, presence: true
  validates :remote_status, presence: true
  validates :remote_md5, presence: true
  validates :remote_source, presence: true
  validates :post, presence: true
  validates :remote_file_type, presence: true
  validates :remote_source, presence: true, inclusion: { in: RemoteIqdbMatch.sources.keys }
  validates :remote_status, presence: true, inclusion: { in: RemoteIqdbMatch.statuses.keys }
  validates :remote_file_type, presence: true, inclusion: { in: RemoteIqdbMatch.remote_file_types.keys }
  validates :bit_depth
  validates :flags


  def get_magick_info
    # e999_todo placeholder 
    # Download file from remote_url
    file, _strategy = Downloads::File.new(image_url).download!
    rescue Downloads::File::Error
      # e999_todo report this for later
    end

    # move to a model for general image flags

    # gets the image information by shelling out for ImageMagick
    # estimate compression based on file size, width, height, and bit depth
    # check if the file has an alpha channel or color profile
    # check if the file has multiple frames

    # begin
    #   magick_info = Magick::Image.ping(file.path).first
    #   {
    #     width: magick_info.columns,
    #     height: magick_info.rows,
    #     bit_depth: magick_info.depth,
    #     has_alpha_channel: magick_info.alpha?,
    #     has_color_profile: magick_info.color_profile?,
    #     compression: magick_info.compression,
    #     frames: magick_info.frames
    #   }
    # rescue Magick::ImageMagickError => e
    #   Rails.logger.error("Failed to get image info for #{file.path}: #{e.message}")
    #   nil
    # ensure
    #   file.close if file
    # end
  end



  def remote_url
    # e999_todo placeholder 
    "https://#{remote_source}.com/remote_files/#{remote_id}.#{remote_file_type}"
  end

  # Flags for additional properties
  HAS_ALPHA_CHANNEL   = 0b00000001
  HAS_COLOR_PROFILE   = 0b00000010
  HAS_MULTIPLE_FRAMES = 0b00000100

  def has_alpha_channel?
    (flags.to_i & HAS_ALPHA_CHANNEL) != 0
  end

  def has_alpha_channel=(value)
    self.flags = (flags.to_i & ~HAS_ALPHA_CHANNEL) | (value.to_s == "1" || value == true ? HAS_ALPHA_CHANNEL : 0)
  end

  def has_color_profile?
    (flags.to_i & HAS_COLOR_PROFILE) != 0
  end

  def has_color_profile=(value)
    self.flags = (flags.to_i & ~HAS_COLOR_PROFILE) | (value.to_s == "1" || value == true ? HAS_COLOR_PROFILE : 0)
  end

  def has_multiple_frames?
    (flags.to_i & HAS_MULTIPLE_FRAMES) != 0
  end

  def has_multiple_frames=(value)
    self.flags = (flags.to_i & ~HAS_MULTIPLE_FRAMES) | (value.to_s == "1" || value == true ? HAS_MULTIPLE_FRAMES : 0)
  end
end
