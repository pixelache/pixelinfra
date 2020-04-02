class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :slug, :published, :published_at, :image, :excerpt, :image_width, :image_height, :registration_required, :title, :body, :next_post_by_festival, :previous_post_by_festival
  attribute :creator do |obj|
    obj.creator.name
  end


end
