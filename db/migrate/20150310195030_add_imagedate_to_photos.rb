class AddImagedateToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :image_date, :date
    add_column :archivalimages, :image_date, :date
    Photo.all.each do |p|
      if p.item.class == Post
        p.image_date = p.item.published_at.to_date
      elsif p.item.class == Event
        p.image_date = p.item.start_at.to_date
      end
      p.save!
    end
    Archivalimage.all.each do |ai|
      if ai.festival
        ai.image_date = ai.festival.start_at
      end
      if ai.event
        ai.image_date = ai.event.start_at
      end
      ai.save!
    end

        
  end
end
