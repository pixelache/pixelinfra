class AddOpencallTranslations < ActiveRecord::Migration[5.1]
  def self.up
    Opencall.create_translation_table!  description: :text
  end

  def self.down
    Opencall.drop_translation_table!
  end
end
