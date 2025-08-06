class BaseFileData < ApplicationRecord
  enum file_type: { jpg: 0, png: 1, gif: 2, webp: 3, mp4: 4, webm: 5, jxl: 6, avif: 7 }
  # attr_accessor
      # t.integer :file_type
      # t.integer :file_size
      # t.integer :width
      # t.integer :depth
      # t.integer :height
      # t.string :md5
      # t.integer :flags
      # t.float :compression
  # Bitflags for file properties
  HAS_ALPHA_CHANNEL   = 0b00000001
  HAS_COLOR_PROFILE   = 0b00000010
  HAS_MULTIPLE_FRAMES = 0b00000100
  NUM_CHANNELS        = 0b00011000 # number of channels (1-indexed, 1-4)
  RESERVED_FLAGS      = 0b11100000

  def has_alpha_channel?
    (flags.to_i & HAS_ALPHA_CHANNEL) != 0
  end

  def has_color_profile?
    (flags.to_i & HAS_COLOR_PROFILE) != 0
  end

  def has_multiple_frames?
    (flags.to_i & HAS_MULTIPLE_FRAMES) != 0
  end

  def num_channels
    ((flags.to_i & NUM_CHANNELS) >> 3) + 1
  end

  def file_ext
    return file_type.to_s
  end

  def image_width
    width || 0
  end

  def image_height
    height || 0
  end

  def calculate_compression_ratio
    # use file size compared to channels, height, width, depth, to get a rough estimate of compression
    compression = 0 if size.zero? || width.zero? || height.zero? || depth.zero?

    estimated_size = (width * height * depth * num_channels) / 8.0
    compression = 0 if estimated_size.zero?

    compression = (size.to_f / estimated_size).round(2)
  end
end
