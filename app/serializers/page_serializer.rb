class PageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :body, :published, :sort_order, :slug, :photos
end
