CarrierWave.configure do |config|  
    config.storage = :aws
    config.aws_credentials = {
      :access_key_id      => ENV['S3_ACCESS'],
      :secret_access_key  => ENV['S3_SECRET']
    }
    config.aws_acl    = :public_read
    # config.s3_region = 'eu-west-1'
    config.aws_bucket  = "pixelache-#{Rails.env.to_s}"


  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end