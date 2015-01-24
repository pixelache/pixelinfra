class AddShortdescriptionToProjectTranslations < ActiveRecord::Migration
  def change
    add_column :project_translations, :short_description, :string
  end
end
