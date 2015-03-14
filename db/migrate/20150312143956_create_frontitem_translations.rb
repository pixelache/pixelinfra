class CreateFrontitemTranslations < ActiveRecord::Migration
  def self.up
    rename_column :frontitems, :custom_title, :old_custom_title
    rename_column :frontitems, :custom_follow_text, :old_custom_follow_text
    
    Frontitem.create_translation_table! :custom_title => :string, :custom_follow_text => :string
    I18n.locale = "en"
    Frontitem.all.each do |f|
      
      f.custom_title = f.old_custom_title
      f.custom_follow_text = f.old_custom_follow_text
      f.save
    end
    remove_column :frontitems, :old_custom_title
    remove_column :frontitems, :old_custom_follow_text
    
  end
end
