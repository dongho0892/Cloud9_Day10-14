class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick  # 주석 해제

  # Choose what kind of storage to use for this uploader:
  storage :file   # 이미지 파일 업로드할 때 잠깐 썼음
  
  # storage :fog   # AWS 연계 시키는 과정에서 주석 제외해줌.

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
            # => 이미지 업로드 할 경우 public으로 넘어강.ㅁ
  def store_dir                             # 경로      파일 명
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end       #모델에  post  스트링  소문자로 만듬 / 경로 / 해당 모델의 id




  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb_fit do
    process resize_to_fit: [500, 500]
  end

  version :thumb_fill do
    process resize_to_fill: [500, 500]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:

    # 아무파일이나 올릴 수 있는 것을 방지할 수 있음
  def extension_whitelist
    %w(jpg jpeg gif png)      # 이 것만 허용하는 리스트 
  end
  
  
    # 다른 파일의 경우 다른 칼럼에 마운트 해서 사용해야함.
    # posts.rb => mount_uploader :image_path, ImageUploader
  
    # mount_uploader :file_path, FileUploader   + 파일크기 줄이는 것 삭제...
    # 이런식으로 다른 경로, 업로더를 지정해주어야함.
  
    # rollback transaction이 되어버림 !

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.

  # 저장될 파일의 이름을 지정할 수 있음.

  def filename
    "picture.jpg" if original_filename
  end
end
