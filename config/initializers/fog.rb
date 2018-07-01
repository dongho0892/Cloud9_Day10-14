CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],               #         # required
    aws_secret_access_key: ENV["AWS_SECET_ACCESS_KEY"],                        # required
    region:                'ap-northeast-2',          # 아시아태평양(서울)로 위치 조정해줌        # optional, defaults to 'us-east-1'
    # host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'https://s3.ap-northeast-2.amazonaws.com' # optional, defaults to nil
  }
  
  # optional
  config.fog_directory  = ENV["S3_BUCKET_NAME"]                                   # required
  # 2줄은 삭제함.  / fog/aws로 
  
  #https://docs.aws.amazon.com/ko_kr/general/latest/gr/rande.html
  
end