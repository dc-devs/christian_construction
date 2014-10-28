class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :fog

  def store_dir
    if Rails.env.test?
      "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    elsif Rails.env.production?
      "uploads/production/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/development/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  version :homepage_carousel do
    process :resize_to_fill => [1000, 600]
  end

  version :homepage_carousel_houzz do
    process :resize_to_fill => [1600, 1066]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
