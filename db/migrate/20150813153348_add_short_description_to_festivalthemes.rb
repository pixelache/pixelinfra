class AddShortDescriptionToFestivalthemes < ActiveRecord::Migration
  def change
    Festivaltheme.add_translation_fields! short_description: :text
  end
end
